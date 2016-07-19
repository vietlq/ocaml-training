## The module Language

### Local modules

A module can define child modules:

* Syntax: `module Name = struct ... end`
* They support the same features as top-level modules, including modules
* Access syntax: `Module.F1.`, `Module.F1.F2.`, ...

Local modules are useful for:

* Architecturing the API (by topic, hierarchically, etc.)
* Grouping local utilities tobe hidden.
* Locally extending / patching external modules.
* Defining functor parameters (to be continued).

### Local signatures

Child modules can also be restricted using signatures.

In the parent module signature:

* Syntax: `module Name : sig ... end`.
* Elements inside the `sig` are the same as in `.mli`
* This way, the module is restricted for the outside world.
* It is also possible to hide a child module completely.

Inside the module:

* A child module can also be restricted for the rest of the module.
* Syntax: `module Name : sig .. end = struct ... end`.
* No outside callers can access these child modules

Signatures can be named:

* Syntax: `module type NAME = sig ... end`.
* For use in interfaces: `module Name : NAME`.
* Or implementation : `module Name : NAME = struct ... end`.

### Example: variations on a (key x value) table

Check `048_key_value_storage` for more details.

Ideally for `In_memory_table.init`, we want to have the last param to be of type `unit` and not `string` and then omitted. To achieve this, we will need interface rewriting in the next part.

### Abstraction and signature rewriting

The abstract types of a named interface can be refined in two ways:

* Variant 1:
 * `NAME with type t = def`
 * This will build the same interface with `t` publicly specified to be `def`
* Variant 2:
 * `NAME with type t := def`
 * This will remove the declaration of `t` and replace all its occurences with `def`

Let's say we have an interface:

```ocaml
module type OF_STRING = sig
    type t
    val of_string : string -> t
end
```

We can rewrite it as follows:

```ocaml
module Float_of_string : OF_STRING with type t = float
```

The line above is equivalent to writing:

```ocaml
module Float_of_string : sig
    type t = float
    val of_string : string -> t
end
```

Alternatively, we can make `t` disappear:

```ocaml
module Float_of_string : OF_STRING with type t := float
```

The line above is equivalent to writing:

```ocaml
module Float_of_string : sig
    val of_string : string -> float
end
```

In our case, we could do the following to the `TABLE`:

```ocaml
module type TABLE = sig
    type 'a table
    type param
    val init : ('a -> string) -> (string -> 'a) -> param -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
end

(* Then the modules could be given refined signatures *)
module In_memory_table : TABLE with type param := unit

module On_disk_table : TABLE with type param := string
```

### Composition

Another module language primitive is `include`.

In signatures:

* To type module level inheritance
* With signature rewriting, to type module level traits
* Syntax: `include NAME`
* With rewriting: `include NAME with type ...`

In implementation:

* To extend or patch existing modules
* Syntax: `include Name`
* With signature: `include (Name : NAME)`
* With rewritten signature: `include (Name : NAME with type ...)`

#### Monomorphic restrictions

One could provide pre-instanced cached tables for primitive types. Their interface is simpler, say for Int_table:

```ocaml
module Int_table : sig
    type t
    val init : string -> t
    val put : string -> int -> t -> unit
    val get : string -> t -> int
end
```

Here's generic interface for monomorphic modules:

```ocaml
module type TYPED_TABLE = sig
    type t
    type value
    val init : string -> t
    val put : string -> value -> t -> unit
    val get : string -> t -> value
end

(* Instantiate by rewriting - equivalent to C++ template specialization *)
module Int_table : TYPED_TABLE with type value := int
module Float_table : TYPED_TABLE with type value := float
module String_table : TYPED_TABLE with type value := string
```

When implementing modules, we patch polymorphic implementation:

```ocaml
module Int_table = struct
    (* All definitions of In_memory_table are available *)
    include In_memory_table
    (* Set the correct table type *)
    type t = int table
    (* Wrap In_memory_table.init *)
    let init dir = init string_of_int int_of_string dir
end

module Float_table = struct
    (* All definitions of In_memory_table are available *)
    include In_memory_table
    (* Set the correct table type *)
    type t = float table
    (* Wrap In_memory_table.init *)
    let init dir = init string_of_float float_of_string dir
end

module String_table = struct
    (* All definitions of In_memory_table are available *)
    include In_memory_table
    (* Set the correct table type *)
    type t = string table
    (* Wrap In_memory_table.init *)
    let init dir = init (fun s -> s) (fun s -> s) dir
end
```


