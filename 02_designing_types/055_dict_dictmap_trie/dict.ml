type dict = Node of bool * (char * dict) list

let empty = Node (false, [])

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

let rec insert s d =
    let rec descend = function
        | [], Node (_, subs) -> Node (true, subs)
        | [x], Node (ended, []) -> Node (ended, [(x, Node (true, []))])
        | x :: y :: xs, Node (ended, []) -> Node (ended, [(x, descend (y :: xs, empty))])
        | x :: xs, Node (ended, (c, d) :: rest) -> (
            if x = c then
                Node (ended, (c, descend (xs, d)) :: rest)
            else
                let Node (_, newrest) = descend (x :: xs, Node (ended, rest)) in
                Node (ended, (c, d) :: newrest)
        )
    in
    match explode s with
    | [] -> invalid_arg "insert empty string"
    | chars -> descend (chars, d)

let rec present s d =
    let rec descend = function
        | [], Node (ended, _) -> ended
        | _ :: _, Node (_, []) -> false
        | x :: xs as chars , Node (ended, (c, d) :: rest) ->
            if x = c then descend (xs, d)
            else descend (chars, Node (ended, rest))
    in descend (explode s, d)

let iter f d =
    let rec descend acc sofar = function
        | Node (b, []) as node -> f acc sofar node
        | Node (b, (c, d) :: rest) -> (
            let newacc = f acc sofar (Node (b, [])) in
            let dfs = descend newacc (c :: sofar) d in
            descend dfs sofar (Node (false, rest))
        )
    in
    List.rev @@ descend [] [] d

let keys d =
    let to_key chars =
        let len = List.length chars in
        let bytes = Bytes.create len in
        List.iteri (fun i c -> Bytes.set bytes (len - i - 1) c) chars ;
        Bytes.to_string bytes
    in
    let f acc sofar (Node (b, _)) = if b then to_key sofar :: acc else acc in
    iter f d

