## Using Standard Functors

### Functor Application

What are functors?

* Parametric modules
* Module level functions

The code of a functor:

* Assumes that some module of a given signature exist
* Is linked to a such module by a `functor application` at runtime

Syntax:

* Functor signatures:
 * `module Name : functor (Arg : ARG) -> RESULT`
* Functor application:
 * `module Instance = Name (Arg).`

### Set and Map

The standard library defines:

* `Set`, functional sets of elements of a given type
* `Map`, functional polymorphic maps of keys of a given type

For constructing maps, the `map.mli` exports the functor:

`module Make (Ord : OrderedType) : S with type key = Ord.t`

* `OrderedType` is the signature that the parameter must respect
* `S` is the signature of the result. It is linked to the parameter by the `with type` syntax

```ocaml
module type OrderedType = sig
    type t
    val compare : t -> t -> int
end
```

```ocaml
module type S = sig
    type key
    type (+ 'a) t
    val empty : 'a t
    val is_empty : 'a t -> bool
    (* ... more ... *)
end
```

Let's instantiate `Map` to build maps of strings:

```ocaml
module StringOrderedType = struct
    type t = string
    let compare = Pervasives.compare
end

module StringMap = Map.Make (String)
```

Now `StringMap` is usable like any other module. There's a more compact way to produce `StringMap`:

```ocaml
module StringMap = Map.Make (struct
    type t = string
    let compare = Pervasives.compare
end)
```

The module `String` has already defind `t` and `compare`, so we can use directly:

```ocaml
module StringMap = Map.Make (String)
```

If a map is only required for a local computation, one can write:

```ocaml
let module StringMap = Map.Make (String) in (* expression *)
```

