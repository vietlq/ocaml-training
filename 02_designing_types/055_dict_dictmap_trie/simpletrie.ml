type ('a, 'b) trie = Node of 'b option * ('a * ('a, 'b) trie) list

let empty = Node (None, [])

let rec set key v d =
    let rec descend = function
        | [], Node (_, subs) -> Node (Some v, subs)
        | [x], Node (ended, []) -> Node (ended, [(x, Node (Some v, []))])
        | x :: y :: xs, Node (ended, []) -> Node (ended, [(x, descend (y :: xs, empty))])
        | x :: xs, Node (ended, (c, d) :: rest) -> (
            if x = c then
                Node (ended, (c, descend (xs, d)) :: rest)
            else
                let Node (_, newrest) = descend (x :: xs, Node (ended, rest)) in
                Node (ended, (c, d) :: newrest)
        )
    in
    match key with
    | [] -> invalid_arg "set empty key"
    | key -> descend (key, d)

let rec get key d =
    let rec descend = function
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

let iter f d =
    let rec descend acc sofar = function
        | Node (opt, []) as node -> f acc sofar node
        | Node (opt, (c, d) :: rest) -> (
            let newacc = f acc sofar (Node (opt, [])) in
            let dfs = descend newacc (c :: sofar) d in
            descend dfs sofar (Node (None, rest))
        )
    in
    List.rev @@ descend [] [] d

let keys d =
    let f acc sofar (Node (opt, _)) =
        match opt with
        | None -> acc
        | Some _ -> List.rev sofar :: acc
    in
    iter f d

let items d =
    let f acc sofar (Node (opt, _)) =
        match opt with
        | None -> acc
        | Some v -> (List.rev sofar, v) :: acc
    in
    iter f d

