## Polymorphic Variants, Labels

### Labeled & Optional Arguments

#### Labeled Arguments

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

#### Optional Arguments

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
let concat ?sep:string strings =
    let rec aux strings =
        match strings, sep with
        | [], _ -> ""
        | [single], _ -> single
        | word :: words, Some sep -> word ^ sep ^ cat words
        | word :: words, None -> word ^ cat words
    in
    aux strings
```

### Polymorphic Variants

### Patterns

### References

