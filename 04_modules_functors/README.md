## Toplevel Modules

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
    -$(RM) -f *.cmx *.cmx *.cmo *.cmxa testfifo.native
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

Make sure to edit the generated file `realtimefifo.mli` to keep interface tidy & nice.

### Interface compilation

### Documentation

## Abstraction

## The module Language

## Using Standard Functors

