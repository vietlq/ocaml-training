type dict = Empty | Node of bool * (char * dict) list

let empty = Empty

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

let rec insert s d =
    let rec descend = function
        | [], Empty -> Empty
        | [x], Empty -> Node (false, [(x, Node (true, []))])
        | x :: y :: xs, Empty -> Node (false, [(x, descend (y :: xs, Empty))])
        | [], Node (_, subs) -> Node (true, subs)
        | [x], Node (ended, []) -> Node (ended, [(x, Node (true, []))])
        | x :: y :: xs, Node (ended, []) -> Node (ended, [(x, descend (y :: xs, Empty))])
        | x :: xs, Node (ended, (c, d) :: rest) -> (
            if x = c then
                Node (ended, (c, descend (xs, d)) :: rest)
            else
                match descend (x :: xs, Node (ended, rest)) with
                | Empty -> assert false
                | Node (_, newrest) -> Node (ended, (c, d) :: newrest)
        )
    in
    match explode s with
    | [] -> d
    | chars -> descend (chars, d)

let rec present s d =
    let rec descend = function
        | _, Empty -> false
        | [], Node (ended, _) -> ended
        | _ :: _, Node (_, []) -> false
        | x :: xs as chars , Node (ended, (c, d) :: l) ->
            if x = c then descend (xs, d)
            else descend (chars, Node (ended, l))
    in descend (explode s, d)

