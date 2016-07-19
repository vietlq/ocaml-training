## Top-level Modules

### Source units as modules

* Each file `something.ml` defines a module named `Something`
* Its names can be accessed from other modules prefixed by `Something.`
* One can omit the prefix `Something.` by using `open Something ;;` or `let open Something in`
* One also can use `Momo.(...)` and `Modo.{...}` in expressions
* The module relationship is a partial order (must be acyclic, no cycles)

Let's say we have a file `fifo.ml`:

```ocaml
exception Empty

type 'a fifo = { front : 'a list ; rear : 'a list }

let empty = { front = [] ; rear = [] }

let pop fifo =
    match fifo.front with
    | [] -> raise Empty
    | x :: front -> x, { fifo with front }
```

If we want to use `fifo.ml` in `main.ml`:

```ocaml
let empty_fifo = Fifo.empty

let check_result fifo =
    match pip fifo with
    | exception Fifo.Empty -> ...
    | x -> ...

let do_something fifo =
    let open Fifo in
    let x = pop fifo in
    ...

open Fifo ;;
(* From now on all public names of Fifo are accessible without using Fifo. prefix *)
```

### Separate compilation

Multi-modular programs can be compiled in one invocation:

`ocamlopt fifo.ml main.ml -o testfifo.native`

Note that the order is important

The modules can be compiled separately too:

```
ocamlopt -c fifo.ml
ocamlopt -c main.ml
ocamlopt fifo.cmx main.cmx -o testfifo.native
```

A simple `Makefile`:

```Makefile
testfifo.native: fifo.cmx main.cmx
    ocamlopt $^ -o $@

%.cmx: %.ml
    ocamlopt -c $<

clean:
    rm -f *.cmx *.cmx *.cmo *.cmxa testfifo.native
```

For more robust building methods, refer to 'build_guide.md' at the top of this repo.

### Interfaces

* Each `.ml` file can be accompanied by a `.mli` file with the same prefix.
* The `.mli` file defines interface of the `.ml` file.
* Anything not specified in `.mli` can't be accessed by external callers if they link in compiled interface.
* Interfaces define:
 * The types present in the source, with the same syntax.
 * Each value (function or not) present in the source in the form: `val name: type`

An example from `realtimefifo.mli`:

```ocaml
exception Empty
(* an abstract type *)
type 'a fifo
val empty : 'a fifo
val push : 'a -> 'a fifo -> 'a fifo
val pop : 'a fifo -> 'a * 'a fifo
```

The file `realtimefifo.mli` provides definition for the abstract type `'a fifo` and also it has a few more internal functions that not exposed to the interface file `realtimefifo.mli`.

One can generate a `.mli` from the `.ml` file using:

```
ocamlopt -i realtimefifo.ml > realtimefifo.mli
```

Make sure to edit the generated file `realtimefifo.mli` to keep interface tidy & nice. Check the `build_guide.md` at the top level of this repo.

### Interface compilation

* Interfaces are compiled to `.cmi` files
* When checking a reference to an external module, `ocamlopt` will look for its `.cmi` first
* When an interface is present, `ocamlopt` will require it to be compiled before the source

The updated `Makefile`:

```Makefile
testfifo.native: fifo.cmx main.cmx
    ocamlopt $^ -o $@

%.cmx: %.mli
    ocamlopt -c $<

%.cmx: %.ml
    ocamlopt -c $<

clean:
    rm -f *.cmx *.cmx *.cmi *.cmo *.cmxa testfifo.native
```

If you have complex dependencies, use `ocamldep` & `ocamlbuild`.

### Documentation

The `ocamldoc` tool defines a special syntax for comments:

* Documentation comments are `(** enclosed like this *)`
* Associated to the nearest element (before or after, without linebreaks)
* The first of the file describes the module

Let's update our `realtimefifo.mli` with documentation:

```ocaml
(** An efficient implementation of FIFO that provides real-time guarantee. This implementation uses streams. *)

(** Exception type raised when the FIFO is empty. *)
exception Empty

(** Abstract generic type for the FIFO. *)
type 'a fifo

(** An empty FIFO. One use use this as a starting point & push elements. *)
val empty : 'a fifo

(** Push an element to the FIFO. Amortized O(1) time complexity. *)
val push : 'a -> 'a fifo -> 'a fifo

(** Pop the first element from the FIFO. Amortized O(1) time complexity. *)
val pop : 'a fifo -> 'a * 'a fifo
```

Then we can run `ocamldoc -html realtimefifo.mli` and see the result.

