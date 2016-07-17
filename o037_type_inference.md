## OCaml type inference

### Basics

* May only fail or return a correct type
* Will always return the principal (most generic) type
* May fail on non erroneous programs
* Uses Hindley-Milner style unification

### Intuitively

* The inference starts by giving generic types to everything
* If uses the types of called functions and referenced values
 * To check that the local use is compatible
 * Conversely, to narrow the types of local expressions
* In a single pass called unification:
 * Two generic types are unified as one
 * Two different primitive types are not unified and lead to an error
 * A generic type and a primitive type unify to the primitive

### The inference algo is a recursive descent on the program

* Allocates fresh variables for all its subexpressions
* Applies predefined typing rules for relating the subexpressions:
 * The condition of an `if` is unified with bool
 * The branches of a `match` are unified together
 * The function parameters and arguments are unified pairwise, etc. by calling the unification recursively
* Finally unifies the expression result `type` with the expected one

### Destructive unification is used

* Types variables are references
* Unifying a *type variable* with a *primitive type* results in destruction of the variable
* Trying to update an already destroyed variable leads to a type clash
* Updating one occurence will update all (so a variable can only be used with one type)
* When the body of a `let` is completely typed, potential type variables are *generalized*, the result is *polymorphic*

### Troubleshoooting

* Why some annotations seem ignored (think about aliases)
* Why some functions end up more polymorphic than expected
* Why some error message are little cryptic

### Limitations

#### Disambiguation of constructs and fields:

* Necessary when several records have the same name
* The inference takes the last definition by default
* Solved with annotations

#### Weak type variables

* Some values have type variables that cannot be generalized
* Example: `let storage = ref []`
 * Should be of type 'a list ref
 * Unsafe since one could insert heterogenous values
* The toplevel will display a weak variable: `'_a list ref`
* This kind of variable is updated upon its first monomorphic usage

#### Value restriction

* Once upon a time, only constraints and functions were generalized
* In OCaml this is a lot relaxed, yet correct
* But the heuristics is not perefect
* OCaml may not accept to generalize truly polymorphic values
* The solution is often to turn these variables into functions

#### Polymorphic recursion

* The type of a recursive function is unified with its own usage
* It cannot be polymorphic if used recursively in a monomorphic way

Example:

```ocaml
let rec first x l =
    match l with [] -> x | l :: _ -> l
and f () =
    (first 1 [], first 1. []) ;;
Error: This expression has type float
       but an expression was expected of type int
```

Solution:
```ocaml
let rec first : 'a. 'a -> 'a list -> 'a
    = fun x l -> match l with [] -> x | l :: _ -> l
and f () = (first 1 [], first 1. []) ;;
val first : 'a -> 'a list -> 'a = <fun>
val f : unit -> int * float = <fun>
```

