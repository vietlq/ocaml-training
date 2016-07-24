type ('a, 'b) trie = Empty | Node of 'b option * ('a * ('a, 'b) trie) list

let empty = Empty

let rec set key v d =
    let rec descend = function
        | [], Empty -> Empty
        | [x], Empty -> Node (None, [(x, Node (Some v, []))])
        | x :: y :: xs, Empty -> Node (None, [(x, descend (y :: xs, Empty))])
        | [], Node (_, subs) -> Node (Some v, subs)
        | [x], Node (ended, []) -> Node (ended, [(x, Node (Some v, []))])
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
    match key with
    | [] -> invalid_arg "set empty key"
    | key -> descend (key, d)

let rec get key d =
    let rec descend = function
        | _, Empty -> None
        | [], Node (ended, _) -> ended
        | _ :: _, Node (_, []) -> None
        | x :: xs as chars , Node (ended, (c, d) :: rest) ->
            if x = c then descend (xs, d)
            else descend (chars, Node (ended, rest))
    in
    match descend (key, d) with
    | None -> raise Not_found
    | Some v -> v

let rec present key d =
    match get key d with
    | exception Not_found -> false
    | v -> true

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

