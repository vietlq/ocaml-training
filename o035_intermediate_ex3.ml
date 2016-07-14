type 'a bin = Bnil | Bnode of 'a bin * 'a * 'a bin

(* Infix, non-tail recursive *)
let rec to_list = function
    | Bnil -> []
    | Bnode (left, a, right) -> (to_list left) @ ( a :: to_list right)

(* Infix, tail-recursive *)
let to_list_tail bin =
    let rec aux acc = function
        | Bnil -> acc
        | Bnode (left, a, right) ->
            aux (a :: (aux acc left)) right
    in aux [] bin

(* Generic prefix traversal *)
let rec prefix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> (prefix f (prefix f (f acc a) left) right)

(* Generic infix traversal *)
let rec infix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> (infix f (f (infix f acc left) a) right)

(* Generic postfix traversal *)
let rec postfix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> (f (postfix f (postfix f acc left) right) a)

