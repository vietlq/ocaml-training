## The Module Language

### Functor Definition

#### Functor Definition

Syntax:

* Basic definition: `module F (X : T) = struct ... end`
* The type of the argument must be given
* The return type of the functor is inferred and the most general
* `F` is the name of the functor
* `X` is the name of the argument usable in the body
* `T` can be any signature

Optionally:

* The result signature can be specified
* Signature definition: `module F (X : T) : sig ... end = struct ... end`
* `X` is usable in the signature body: `module F (X : T) : sig type t = X.t end = struct ... end`
* Named defition: `module F (X : T) : S = struct ... end`
* The argument and return can also be related with signature rewriting: `module F (X : T) : S with type t = X.t = struct ... end`

#### Example: Multisets

A naive implementation of multisets

```ocaml
let empty = []

let rec add elt = function
    | [] -> [ (elt, 1) ]
    | (e, m) :: rest when elt = e -> (e, succ m) :: rest
    | (e, _) as p :: rest when elt > e -> p :: (elt, 1) :: rest
    | p :: rest -> p :: add elt rest

let rec multiplicity elt = function
    | [] -> 0
    | (e, _) :: rest when elt > e -> 0
    | (e, m) :: rest when elt = e -> m
    | _ :: rest -> multiplicity elt rest
```

There's a simple & compatible interface:

* For documentation
* To hide the type and protect the sorted invariant

```ocaml
module Multiset : sig
    type 'a t
    val empty : 'a t
    val add : 'a -> 'a t -> 'a t
    val multiplicity -> 'a -> 'a t -> int
end = struct
    type 'a t = ('a * int) list
end
```

Now we want to build a functorial interface:

* To build distinguished multiset types over a same type
* To use ad-hoc comparison instead of OCaml's

The functor will require:

* The type of elements
* And a `compare` function over the elements

The functor parameter signature is:

```ocaml
module type ELEMENT = sig
    type t
    val compare : t -> t -> int
end
```

Then we write the functor definition, replacing OCaml's comparison

```ocaml
module Make_multiset (E : ELEMENT) = struct
    type t = (E.t * int) list
    
    let empty = []
    
    let rec add elt = function
        | [] -> [ (elt, 1) ]
        | (e, m) :: rest when E.compare elt e = 0 -> (e, succ m) :: rest
        | (e, _) as p :: rest when E.compare elt e > 0 -> p :: (elt, 1) :: rest
        | p :: rest -> p :: add elt rest

    let rec multiplicity elt = function
        | [] -> 0
        | (e, _) :: rest when E.compare elt e > 0 -> 0
        | (e, m) :: rest when E.compare elt e = 0 -> m
        | _ :: rest -> multiplicity elt rest
end
```

With the inferred syntax, `type t = (E.t * int) list` is public, hence:

* One can break the invariants from the outside
* We have to restrict the result with a signature with `t` abstract

So the improved design should be:

```ocaml
module Make_multiset (E : ELEMENT) : sig
    type t
    val empty : t
    val add : E.t -> t -> t
    val multiplicity : E.t -> t -> int
end = struct
    (* ... *)
end
```

There are still 2 problems with this design:

* Explicit reliance on E.t in the interface. A parameter would help
* Inlining is just ugly `sig ... end = struct ... end`

So we have a better design:

```ocaml
module type MULTISET = sig
    type t
    type elt
    val empty : t
    val add : elt -> t -> t
    val multiplicity : elt -> t -> int
end

module Make_multiset : functor (E : ELEMENT) -> MULTISET with type elt = E.t
```

And here's the definition:

```ocaml
module Make_multiset (E : ELEMENT) : MULTISET with type elt = E.t = struct
    type elt = E.t
    type t = (elt * int) list
    (* ... *)
end
```

#### Functor Signatures

A functor must appear with its type in interfaces, as any other module:

* Simple syntax: `module F : functor (X : T) -> sig ... end`
* With named result: `module F : functor (X : T) -> S`
* With rewriting: `module F : functor (X : T) -> S with type t = X.t`

Thus, for the example above, we have the following interfaces:

```ocaml
module type ELEMENT = sig
    type t
    val compare : t -> t -> int
end

module type MULTISET = sig
    type t
    type elt
    val empty : t
    val add : elt -> t -> t
    val multiplicity : elt -> t -> int
end

module Make_multiset : functor (E : ELEMENT) -> MULTISET with type elt = E.t
```

#### Functor Application

A small test program:

```ocaml
let () =
    let module SMS = Make_multiset (String) in
    let items = ["a"; "a"; "c"; "b"; "c"; "c"] in
    let sms = List.fold_right SMS.add items SMS.empty in
    assert
        (List.map
            (fun x -> SMS.multiplicity x sms)
            ["a"; "b"; "c"; "d"]
            = [2; 1; 3; 0])
```

Now we want to have two multiset instances:

```ocaml
let module Wines = Make_multiset (String) in
let module Beers = Make_multiset (String) in
let win_cellar = ref Wines.empty in
let beer_cellar = ref Beers.empty in
wine_cellar := Wines.add "Bordeaux" !wine_cellar ;
wine_cellar := Wines.add "Moscato" !wine_cellar ;
wine_cellar := Beers.add "Heineken" !wine_cellar ;
wine_cellar := Wines.add "St-Emilion" !wine_cellar ;

(* Now the wine cellar got a Heineken and the program will accept it! *)
```

Note that Heineken was added peacefully to the wine cellar.

OCaml considers equal all applications of a functor to the *same* module:

* This equality is based on the *name*, not *structure*
* We have `Wines.t = Wines.t = Make_multiset (String).t`
* However, module aliases recognized: `module S1 = String ;; module S2 = String`. That makes `S1` and `S2` equal
* The same happens with `Map` from the standard library

This optimization is sure smart and can be useful, however, we don't want this aliasing.

There are 3 ways to fix the issue:

* Define two new named modules with the same elements:

```ocaml
module Wine_name = struct
    type t = string
    let compare = Pervasives.compare
end

module Beer_name = struct
    type t = string
    let compare = Pervasives.compare
end
```

* Copy the contents of `String` twice:

```ocaml
module Wine_name = struct include String end
module Beer_name = struct include String end
```

* Use anonymous modules: `struct include String end` directly

Thus, we don't use the module `String` directly now:

```ocaml
let () =
    let module Wines = Make_multiset (struct include String end) in
    let module Beers = Make_multiset (struct include String end) in
    (* ... *)
```

This solves issue with calling `Beers` methods on instances of `Wines`.

### First Class Modules

* Make a module a value: `let m = (module M : S)`. Locally: `let m = (module M : S) in ...`
* Make a value a module: `module M = (val m : S)`. Locally: `let module M = (val m : S) in ...`
* Type of a first class module: `(module S)`

Usage examples:

* Run-time selection of an implementation
* Plug-ins, combined with dynlink
* Alternative to objects

Example:

* Different implementation for a same type
* Implementation stored in the value with the instance

The type of (string x string table):

```ocaml
module type TABLE = sig
    type table
    type param
    val init : param -> table
    val put : string -> string -> table -> unit
    val get : string -> table -> string
end
```

In-memory implementation:

```ocaml
module In_memory_table = struct
    type table = (string, string) Hashtbl.t
    type param = unit
    let init () = Hashtbl.create 100
    let put k v table = Hashtbl.replace table k v
    let get k table = Hashtbl.find table k
end
```

On-disk implementation:

```ocaml
module On_disk_table = struct
    type table = string
    type param = string
    let init to_string of_string dir =
        Unix.mkdir dir 0o750 ;
        dir
    let put k v dir =
        let fp = open_out (Filename.concat dir k) in
        output_string fp v ;
        close_out fp
    let get k dir =
        let fn = Filename.concat dir k in
        if not (Sys.file_exists fn) then raise Not_found ;
        let fp = open_in fn in
        let len = in_channel_length fp in
        let buf = Bytes.create len in
        really_input fp buf 0 len ;
        close_in fp ;
        Bytes.to_string buf
end
```

An intermediate module type, storing the implementation and instance:

```ocaml
module type TABLE_INSTANCE = sig
    include TABLE
    val instance : table
end
```

The first class module type and its primitives:

```ocaml
type table = (module TABLE_INSTANCE)

let in_memory_table =
    let module Instance = struct
        include In_memory_table
        let instance = init ()
    end
    in
    (module Instance : TABLE_INSTANCE)

let put (module Table : TABLE_INSTANCE) k v = Table.(put k v instance)

let get (module Table : TABLE_INSTANCE) k = Table.(get k instance)
```

