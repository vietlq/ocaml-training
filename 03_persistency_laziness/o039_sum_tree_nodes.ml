(*
 * Tree
 * Given the following definition of a tree where nodes are labeled with integer,
 * write a function that sum all the labels of a given tree.
*)
type tree = Empty | Node of tree * int * tree

(* Declarative, non-tail recursive *)
let rec sum t =
    match t with
    | Empty -> 0
    | Node (t1, i, t2) -> i + sum t1 + sum t2

(* Provide a generic fold combinator
 * then get sum & product
 * Not tail-recursive
*)
let rec fold_tree : (int -> 'a -> 'a) -> 'a -> tree -> 'a =
    fun f acc t ->
        match t with
        | Empty -> acc
        | Node (t1, i, t2) ->
            let acc = fold_tree f acc t2 in
            let acc = fold_tree f acc t1 in
            f i acc

let sum t = fold_tree ( + ) 0 t
let product t = fold_tree ( * ) 1 t

(* Provide a generic fold combinator
 * then get sum & product
 * Is tail-recursive
*)
let rec fold_tree : (int -> 'a -> 'a) -> 'a -> tree -> 'a =
    fun f acc t ->
        match t with
        | Empty -> acc
        | Node (t1, i, t2) ->
            fold_tree f (fold_tree f (f i acc) t1) t2

let sum t = fold_tree ( + ) 0 t
let product t = fold_tree ( * ) 1 t

(*
 * Tail recursive with concrete continuation
 * Concrete continuation - each node (concrete value)
 * is then added to accumulator cont
*)
let sum t =
    let rec loop cont acc t =
        match t with
        | Empty -> (
            match cont with
            | [] -> acc
            | t :: cont -> loop cont acc t
        )
        | Node (t1, i, t2) -> loop (t2 :: cont) (i + acc) t1
    in
    loop [] 0 t

(*
 * Tail recursive with functional continuation
 * Function continuation - each node results in one more function added to cont
*)
let sum t =
    let rec loop cont acc t =
        match t with
        | Empty -> cont acc
        | Node (t1, i, t2) ->
            loop (fun acc -> loop cont acc t2) (i + acc) t1
    in
    loop (fun acc -> acc) 0 t

