(* A binary tree *)
type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(* Represents path from top to a node in the tree *)
type 'a path =
    | Top
    | Left of 'a path * 'a * 'a tree
    | Right of 'a tree * 'a * 'a path

(* Path represents the path from the current node to the root *)
type 'a tree_zipper = {
    path : 'a path ;
    tree : 'a tree
}

let of_tree tree = { path = Top ; tree }

let down_right { path ; tree } =
    match tree with
    | Empty -> invalid_arg "down_right"
    | Node (l, x, r) -> { path = Right (l, x, path) ; tree = r }

let down_left { path ; tree } =
    match tree with
    | Empty -> invalid_arg "down_left"
    | Node (l, x, r) -> { path = Left (path, x, r) ; tree = l }

let up { path ; tree } =
    match path with
    | Top -> invalid_arg "up"
    | Left (oldpath, x, r) -> { path = oldpath ; tree = Node (tree, x, r) }
    | Right (l, x, oldpath) -> { path = oldpath ; tree = Node (l, x, tree) }

let rec to_tree { path ; tree } =
    match path with
    | Top -> tree
    | _ -> to_tree @@ up { path ; tree }

