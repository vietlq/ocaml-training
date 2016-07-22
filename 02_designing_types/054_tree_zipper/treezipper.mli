type 'a tree = Empty | Node of 'a tree * 'a * 'a tree
type 'a path =
    Top
  | Left of 'a path * 'a * 'a tree
  | Right of 'a tree * 'a * 'a path
type 'a tree_zipper = { path : 'a path; tree : 'a tree; }
val of_tree : 'a tree -> 'a tree_zipper
val down_right : 'a tree_zipper -> 'a tree_zipper
val down_left : 'a tree_zipper -> 'a tree_zipper
val up : 'a tree_zipper -> 'a tree_zipper
val to_tree : 'a tree_zipper -> 'a tree
