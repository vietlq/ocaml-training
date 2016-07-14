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
            aux ( a:: (aux acc left)) right
    in aux [] bin

