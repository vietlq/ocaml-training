## Accumulators, Continuations, Mutations

*Accumulator* is a common pattern to

* Allow tail recursion and avoid stack overflow
* Define generic iterator like List.fold_left

*Continuation* is a functional parameter of a function, that will be applied to the returned value (instead of simply returning the value)

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

* **Invariant 1**: No red as a red child
* **Invariant 2**: Every path from the root to and empty node/leaf contains the same number of black nodes

