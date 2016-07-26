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

#### Optional Arguments

### Polymorphic Variants

### Patterns

### References

