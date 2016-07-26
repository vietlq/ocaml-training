# Polymorphic Variants, Labels

## Labeled & Optional Arguments

### Labeled Arguments

Let's define a function that adds a prefix & a postfix to a string:

```ocaml
let delimit pre s post = pre ^ s ^ post
```

In the signature, it appears as:

```ocaml
val delimit : string -> string -> string -> string
(**
    [delimit pre s post] adds a prefix and a postfix to a string [s]
*)
```

We can see that the function is ambiguous and needs documentation in the form of comments.

An alternative definition using labels:

```ocaml
let delimit ~pre s ~post = pre ^ s ^ post
```

In signature, it appears as:

```ocaml
val delimit : pre:string -> string -> post:string -> string
```

Now it is much easier to read and comprehend the signature.

There are many ways to apply the function:

```ocaml
delimit "<" "xx" ">" ;;
delimit ~pre:"<" "xx" ~post:">" ;;
delimit ~post:"<" "xx" ~pre:">" ;;
delimit ~post:"<" ~pre:">" "xx" ;;
delimit "xx" ~post:"<" ~pre:">" ;;
```

**Note**:

* Labels can be omitted if all arguments are passed
* Labeled arguments can be put in any order, mixed with others
* Other arguments must be passed in declaration order

Partial application:

```ocaml
let prefix = delimit ~post:""
let postfix = delimit ~pre:""
let wrap = delimit ~pre:"(" ~post:")"
```

**Note:** Labels are required for partial application.

Simplification:

```ocaml
let pre = "<" and post = ">" in
delimit ~pre ~post "Great!"
```

### Optional Arguments

Let's write a function that concatenates the strings in a list with a separator:

```ocaml
let rec concat sep = function
    | [] -> ""
    | [single] -> single
    | word :: words -> word ^ sep ^ concat sep words
```

Many times when we want to join strings, we had to write in an ugly way: `concat "" strings`.

So there's a room for improvement and we should think of using optional arguments:

```ocaml
let concat ?sep strings =
    let rec aux strings =
        match strings, sep with
        | [], _ -> ""
        | [single], _ -> single
        | word :: words, Some sep -> word ^ sep ^ aux words
        | word :: words, None -> word ^ aux words
    in
    aux strings
```

There's a shorter version too:

```ocaml
let rec concat ?sep strings = match strings, sep with
    | [], _ -> ""
    | [single], _ -> single
    | word :: words, Some sep -> word ^ sep ^ concat words
    | word :: words, None -> word ^ concat words
```

Usage:

```ocaml
concat ["Hello" ; "World"] ;;
concat ~sep:", " ["Hello" ; "World"] ;;
concat ?sep:(Some ", ") ["Hello" ; "World"] ;;
```

We could get rid of the `option` types by providing a default value:

```ocaml
let rec concat ?(sep = "") = function
    | [] -> ""
    | [single] -> single
    | word :: words -> word ^ sep ^ concat ~sep words
```

Syntax:

* `~arg:val` passes an `'a` value in `var` to an optional argument `?arg:'a`
* `?arg:val` optionally passes an `'a option` to an argument `?arg:'a`
* `~pre:pre` simplifies to `~pre`
* `?arg:arg` simplifies to `?arg`

End of application:

* Application starts once a non-optional, non-labeled argument is passed
* Functions must have a non-optional argument after the optional ones
* A placeholder `()` can be used

The body is executed once the `()` is passed:

```ocaml
let translate ?x ?y ?z () = (* ... *)
```

## Polymorphic Variants

### Sum types with inferred definition

Basic use case: Introduce constructors without type definition:

```ocaml
let arrow : int -> [`Left | `Right | `Both] -> string = fun len head ->
    match head with
    | `Left -> "<" ^ String.make len '-'
    | `Right -> String.make len '-' ^ ">"
    | `Both -> "<" ^ String.make len '-' ^ ">"
```

Syntax:

* Constructors prefixed with a backquote `Constructor
* Type alias:

```ocaml
[`Constructor of type | `Constructor | ... ]
```

### Constructor sharing

Two polymorphic variant types can define the same constructor:

```ocaml
let arrow : int -> [`Left | `Right | `Both] -> string = fun len head ->
    match head with
    | `Left -> "<" ^ String.make len '-'
    | `Right -> String.make len '-' ^ ">"
    | `Both -> "<" ^ String.make len '-' ^ ">"

let parse_arrow_direction : char -> [`Left | `Right | `Knee] = function
    | '<' -> `Left
    | '>' -> `Right
    | _ -> `Knee

let arrow_from_direction dir =
    match parse_arrow_direction dir with
    | (`Left | `Right) as dir -> arrow 20 dir
    | `Knee -> failwith "in the knee"
```

The value `dir` is considered of both variant types and understood by both `parse_arrow_direction` and `arrow`.

### Subtyping

Intuitively, a polymorphic variant constructor:

* Can be seen as a singleton type *`U* is the only value of type ```[`U]```
* Can be included in bigger polymorphic variant types
* ```[`U | `V]``` is the union of singletons ```[`U]``` and ```[`V]```

This generalizes to a partial order (subtyping relation) order on variant types:

* ```[`U]``` is included in ```[`U | `V]```
* ```[`U | `V]``` is included in ```[`U | `V | `W]```
* ```[`U | `V]``` and ```[`V | `W]``` are not compatible

As with object, this is `structural typing`

* Polymorphic variant types do not need names
* Their type is their structure, not their name

The type system handles these subtyping relations, though row variables, as with objects.

In objects, the `..` only meant and possibly other method. For polymorphic variant types, more notations are available:

```ocaml
(* A type whose constructors are `U, `V and `W *)
[`U | `V | `W]

(* A type whose constructors are at least `U, `V and `W *)
[> `U | `V | `W]

(* A type whose constructors are at most `U, `V and `W *)
[< `U | `V | `W]

(* A type whose constructors are `U, `V and optionally `W *)
[< `U | `V | `W > `U | `V | ]
```

Intuition:

* The form ```[< `U | `V | `W]``` is used for expected values

```ocaml
let f : [< `U | `V | `W] list -> unit = fun l ->
    List.iter (function `U -> () | `V -> () | `W -> ()) l
let () = f ([`U ; `U] : `U list)
```

* The value passed may be always `U
* But it may never be `Z
* This is called a `covariant` position

* The form ```[> `U | `V | `W]``` is used for result values

```ocaml
let l : [> `U | `W] = [`U ; `W]
List.iter (function `U -> () | `V -> () | `W -> ()) l
```

* Not treating a value ``` `U, `V or `W ``` would cause an error
* You can try and treat any other constructor safely
* This is called a `contravariant` position

OCaml always infers the most generic type, including row variables and their variance.

This is easily verified with pattern matching:

```ocaml
let f = function `X -> `A | `Y -> `B
```

Is inferred to be of type:

```ocaml
[< `X | `Y] -> [> `A | `B]
```

If the type is too generic, one can refine it with:

* A checked annotation:

```ocaml
let f : [`X | `Y] -> [`A | `B]
    = function `X -> `A | `Y -> `B
```

* An interface:

```ocaml
module M :
sig
    val f : [`X] -> [`A | `B]
end = struct
    let f = function `X -> 'A | `Y -> `B
end
```

For instance if ``` `Y ``` is reserved for module internal use

* A type coercion:

```ocaml
let u = (`U :> [`U | `V])
```

### Aliases

Polymorphic variant types can be named:

```ocaml
type xyz = [`X | `Y | `Z]
```

These names can be used:

* As any other type alias
* Prefixed with a hash to open the type `#xyz` means ``` [> `X | `Y | `Z] ```
* In other variant definitions: ``` type wxyz = [`W | xyz] ```
* In match cases as a shortcut for all constructors: ``` match v with #xyz -> () ```

## Patterns

### Split & join cases

Suppose we have an expression type with operators over bools and ints.

```ocaml
type expr =
    [ `And of bool * bool
    | `Not of bool
    | `Add of int * int
    | `Neg of int ]
```

We can write two dedicated evaluation functions for clarity:

```ocaml
let eval_bool_op = function
    | `And (x, y) -> x && y
    | `Not x -> not x

let eval_int_op = function
    | `Add (x, y) -> x + y
    | `Neg x -> - x
```

Their signatures:

```ocaml
val eval_bool_op : [< `And of bool * bool | `Not of bool ] -> bool

val eval_int_op : [< `Add of int * int | `Neg of int ] -> int
```

We then could join & split cases:

```ocaml
let eval_op = function
    | `And _ | `Not _ as bool_op -> `Bool (eval_bool_op bool_op)
    | `Add _ | `Neg _ as int_op -> `Int (eval_int_op int_op)
```

The function above has the signature:

```ocaml
val eval_op :
  [< `Add of int * int | `And of bool * bool | `Neg of int | `Not of bool ] ->
  [> `Bool of bool | `Int of int ]
```

### Objects, Labels & Variants

Object oriented APIs can be made more appealing with this combination. One of the goal is to simulate constructor overloading. E.g.:

```ocaml
class hbox :
    ?spacing:int ->
    ?homogeneous:bool ->
    ?vertical_align: [< `Top | `Bottom | `Center | `Fill]
    #component list -> component
```

## References

