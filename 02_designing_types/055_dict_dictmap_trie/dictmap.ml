type 'a dictmap = Node of 'a option * (char * 'a dictmap) list

let empty = Node (None, [])

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

let rec set s v d =
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
    match explode s with
    | [] -> invalid_arg "set empty key"
    | chars -> descend (chars, d)

let rec get s d =
    let rec descend = function
        | [], Node (ended, _) -> ended
        | _ :: _, Node (_, []) -> None
        | x :: xs as chars , Node (ended, (c, d) :: rest) ->
            if x = c then descend (xs, d)
            else descend (chars, Node (ended, rest))
    in
    match descend (explode s, d) with
    | None -> raise Not_found
    | Some v -> v

let rec present s d =
    match get s d with
    | exception Not_found -> false
    | v -> true

let keys d =
    let to_key chars =
        let len = List.length chars in
        let bytes = Bytes.create len in
        List.iteri (fun i c -> Bytes.set bytes (len - i - 1) c) chars ;
        Bytes.to_string bytes
    in
    let rec descend acc sofar = function
        | Node (opt, []) -> (
            match opt with
            | None -> acc
            | Some _ -> to_key sofar :: acc
        )
        | Node (opt, (c, d) :: rest) -> (
            let newacc = match opt with
                | None -> acc
                | Some _ -> to_key sofar :: acc
            in
            let dfs = descend newacc (c :: sofar) d in
            descend dfs sofar (Node (None, rest))
        )
    in
    List.rev @@ descend [] [] d

let items d =
    let to_key chars =
        let len = List.length chars in
        let bytes = Bytes.create len in
        List.iteri (fun i c -> Bytes.set bytes (len - i - 1) c) chars ;
        Bytes.to_string bytes
    in
    let rec descend acc sofar = function
        | Node (opt, []) -> (
            match opt with
            | None -> acc
            | Some v -> (to_key sofar, v) :: acc
        )
        | Node (opt, (c, d) :: rest) -> (
            let newacc = match opt with
                | None -> acc
                | Some v -> (to_key sofar, v) :: acc
            in
            let dfs = descend newacc (c :: sofar) d in
            descend dfs sofar (Node (None, rest))
        )
    in
    List.rev @@ descend [] [] d

