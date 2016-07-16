## OCaml type inference

### Basics

* May only fail or return a correct type
* Will always return the principal (most generic) type
* May fail on non erroneous programs
* Uses Hindley-Milner style unification

### Intuitively

* The inference starts by giving generic types to everything
* If uses the types of called functions and referenced values
** To check that the local use is compatible
** Conversely, to narrow the types of local expressions
* In a single pass called unification:
** Two generic types are unified as one
** Two different primitive types are not unified and lead to an error
** A generic type and a primitive type unify to the primitive

### The inference algo is a recursive descent on the program

* Allocates fresh variables for all its subexpressions
* Applies predefined typing rules for relating the subexpressions:
** The condition of an `if` is unified with bool
** The branches of a `match` are unified together
** The function parameters and arguments are unified pairwise, etc. by calling the unification recursively
* Finally unifies the expression result `type` with the expected one

### Destructive unification is used

* Types variables are references
* Unifying a type variable with a primitive type destroys the variable
* Trying to update an already destroyed variable leads to a type clash
* Updating one occurence will update all (so a variable can only be used with one type)
* When the body of a `let` is completely typed, potential type variables are *generalized*, the result is *polymorphic*

