## Accumulators & Continuations

*Accumulator* is a common pattern to

* Allow tail recursion and avoid stack overflow. Read `o038_filter_list.ml` & `o039_sum_tree_nodes.ml`.
* Define generic iterator like List.fold_left. Read `o038_filter_list.ml` & `o039_sum_tree_nodes.ml`.

*Continuation* is a functional parameter of a function, that will be applied to the returned value (instead of simply returning the value)

* Concrete continuation: Values added to a list. Read `o039_sum_tree_nodes.ml`.
* Functional continuation: Values cause new functions to be added to a list or wrapped in another function. Read `o039_sum_tree_nodes.ml`.

## Mutations

*Mutation* is like a master-chef knife:

* A very effective tool
* But also a very dangerous one too

#### What if we avoid mutations

* Freely copy & share data. Without mutations it's safe to do so
* Free your mind of allocation & deallocation, as garbage collection is efficient

```ocaml
let l1 = [1;2;3] ;;
let l2 = 4 :: l1 ;;
let l3 = l2 @ [5] ;;
```

`l2` shares 1, 2, 3 with `l1` and `l3`. Also 4 is shared by `l2` & `l3`.

#### Mutation-free operations

```ocaml
val cons: 'a -> 'a list -> 'a list
val append: 'a list -> 'a list -> 'a list
val map: ('a -> 'b) -> 'a list -> 'b list
val fold_right: ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
```

```ocaml
type 'a bst = Empty | Node of 'a bst * 'a * 'a bst
val mem: 'a -> 'a bst -> bool
val insert: 'a -> 'a bst -> 'a bst
val union: 'a bst -> 'a bst -> 'a bst
val map: ('a -> 'b) -> 'a bst -> 'b bst
val fold: ('a -> 'b -> 'a) -> 'b bst -> 'a -> 'a
```

#### Red-black trees

* Well-balanced binary search tree
* Nodes are colored either in read or black

* **Invariant 1**: No red node has a red child
* **Invariant 2**: Every path from the root to and empty node/leaf contains the same number of black nodes

####How to perform insertion

* Descent into the tree and insert the new node as a read leaf, respecting the binary search tree property
* On the path back to the tree root, rebalance all the sequence of two red nodes
* Tag the root in black

#### Best practices for mutations

* Keep the core of an application to a pure functional setting, or at least, use persistent data structures
* Keep functional interface while using mutation in the implementation

## Laziness

* **OCaml** Strict evaluation: Arguments are evaluated *before* a function call
* **Haskell** Laziness: Arguments are evaluated when *first-used* by the function

#### OCaml allows explicit laziness

* A predefined type: `'a lazy_t`
* A syntactic construction: `lazy expr`, where `lazy` is a keyword
* A function for explicit evaluation: `Lazy.force: 'a lazy_t -> 'a`

#### How laziness works

* Internally, the laziness is implemented with side-effects
* A creation a lazy value, of type `'a lazy_t` is a *frozen* computation
* *Frozen computation* is a closure - representing a function of type `unit -> 'a`
* After the first evaluation, all references to the closure are replaced with the computed value
* A hidden closure may introduce hard to track memory leaks. Use with care

#### More reading about laziness

* http://www.cs.cornell.edu/courses/cs3110/2011sp/lectures/lec24-streams/streams.htm
* https://ocaml.org/learn/tutorials/streams.html
* https://www.reddit.com/r/ocaml/comments/2y7b3p/i_am_new_to_ocaml_is_there_any_way_to_write/
* https://ocaml-batteries-team.github.io/batteries-included/hdoc2/BatLazyList.html
* http://ocaml-batteries-team.github.io/batteries-included/hdoc2/BatSeq.html
* https://github.com/c-cube/gen
* https://github.com/c-cube/sequence

