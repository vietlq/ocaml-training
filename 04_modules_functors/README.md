## Toplevel Modules

### Source units as modules

* Each file `something.ml` defines a module named `Something`
* Its names can be accessed from other modules prefixed by `Something.`
* One can omit the prefix `Something.` by using `open Something ;;` or `let open Something in`
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

### Interfaces

### Interface compilation

### Documentation

## Abstraction

## The module Language

## Using Standard Functors

