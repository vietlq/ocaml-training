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

### First Class Modules

