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

### Abstraction and signature rewriting

### Composition

