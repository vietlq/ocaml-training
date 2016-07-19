## Abstraction

### Structure rewriting & hiding

The interface must not follow the implementation completely

* To hide internal auxiliary elements
* To hide functions that may break internal invariants
* To help provide a more structured documentation

For this, it is possible to:

* Hide types and values
* Reorder everything
* Use type aliases instead of primitive types

Rewriting is allowed as long as:

* The interface is still consistent with the implementation. E.g. an integer in the implementation cannot be exported with type float
* The interface is self consistent. E.g. types are used after their definition, etc.

We speak of *structural inclusion* between:

* The internal structure, inferred by OCaml
* The external structure, written by the programmer

This inclusion is checked when compiling the implementation.

### Abstract types

Why do we need type abstraction?

* Usual point: To control the implementation
* To clarify the API documentation (not always the best solution)
* To preserve internal invariants
* For program architecture: Write abstract interfaces first
* For quick prototyping

```ocaml
type t
val origin : t
val above : t -> t -> bool
```

**Notes:**

* One cannot use pattern matching on `t`!
* One cannot directly create any instance of `t`. To solve:
 * One must go through make functions or constructors.
 * Library owners must provide necessary builders & accessors.
* Type coercion doesn't work on abstract types (works on private types).

```ocaml
type t
val origin : t
val translate : t -> int -> int -> t
val above : t -> t -> bool
```

```ocaml
let o = Game.origin
let p = Game.(translate x 4 origin)
let () = assert (Game.above p o)
```

### Private types

A less brutal alternative to type abstraction:

* Syntax: `type t = private ...`
* The definition is kept public and appears in the API.
* Values cannot be constructed outside of the module.
* Values can be destructed outside of the module.

Differences with type abstraction:

* Less possibilities of implementation rewrite => BAD!
* Can preserve internal invariants => Very BAD!
* Can make the documentation clearer => Good.
* Makes values destructible for the outside => Good.
* No need for accessors, just builders => Good.
* Allows type coercion and can be slightly more efficient and simple in some cases => Good.

**Note:** A same interface can contain public, private and abstract types.

The updated interface file:

```ocaml
type t = private { x : int ; y : int }
val origin : t
val translate : t -> int -> int -> t
val above : t -> t -> bool
```

