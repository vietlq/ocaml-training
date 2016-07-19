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
    val init : ('a -> string) (string -> 'a) -> param -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
end

(* Then the modules could be given refined signatures *)
module In_memory_table : TABLE with type param := unit

module On_disk_table : TABLE with type param := string
```

### Composition

