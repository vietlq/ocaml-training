type color = Red | Black
type 'a bst = Empty | Node of color * 'a bst * 'a * 'a bst
type 'a t = 'a bst

let rec mem x t =
    match t with
    | Empty -> false
    | Node (_, l, y, r) ->
        if x < y then mem x l
        else if y < x then mem x r
        else true

let balance = function
    | Black, Node(Red, Node(Red, a, x, b), y, c), z, d
    | Black, Node(Red, a, x, Node(Red, b, y, c)), z, d
    | Black, a, x, Node(Red, Node(Red, b, y, c), z, d)
    | Black, a, x, Node(Red, b, y, Node(Red, c, z, d)) ->
        Node(Red, Node(Black, a, x, b), y, Node(Black, c, z, d))
    | c, t1, x, t2 -> Node(c, t1, x, t2)

let insert x t =
    let rec ins t =
        match t with
        | Empty -> Node(Red, Empty, x, Empty)
        | Node(c, t1, y, t2) ->
            if x < y then balance (c, ins t1, y, t2)
            else if y < x then balance (c, t1, y, ins t2)
            else t
    in
    match ins t with
    | Empty -> assert false
    | Node(_, t1, x, t2) -> Node(Black, t1, x, t2)

