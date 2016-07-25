type 'a tst = Empty | Node of 'a option * char * 'a tst * 'a tst * 'a tst

let empty = Empty

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

let set s v t =
    let rec descend = function
        | [], _ -> assert false
        | [x], Empty -> Node (Some v, x, Empty, Empty, Empty)
        | x :: y :: chars, Empty -> Node (None, x, Empty, descend (y :: chars, Empty), Empty)
        | [x], Node (opt, c, l, m, r) ->
            if x < c then Node (opt, c, descend ([x], l), m, r)
            else if x > c then Node (opt, c, l, m, descend ([x], r))
            else Node (Some v, c, l, m, r)
        | x :: y :: chars, Node (opt, c, l, m, r) ->
            if x < c then Node (opt, c, descend (x :: y :: chars, l), m, r)
            else if x > c then Node (opt, c, l, m, descend (x :: y :: chars, r))
            else Node (opt, c, l, descend (y :: chars, m), r)
    in
    match explode s with
    | [] -> invalid_arg "set Empty key"
    | chars -> descend (chars, t)

let get s t =
    let rec descend = function
        | [], _ | _, Empty -> None
        | [x], Node (opt, c, l, _, r) ->
            if x < c then descend ([x], l)
            else if x > c then descend ([x], r)
            else opt
        | x :: y :: chars, Node (opt, c, l, m, r) ->
            if x < c then descend (x :: y :: chars, l)
            else if x > c then descend (x :: y :: chars, r)
            else descend (y :: chars, m)
    in
    match descend (explode s, t) with
    | None -> raise Not_found
    | Some v -> v

let present s t =
    let rec descend = function
        | [], _ | _, Empty -> None
        | [x], Node (opt, c, l, _, r) ->
            if x < c then descend ([x], l)
            else if x > c then descend ([x], r)
            else opt
        | x :: y :: chars, Node (opt, c, l, m, r) ->
            if x < c then descend (x :: y :: chars, l)
            else if x > c then descend (x :: y :: chars, r)
            else descend (y :: chars, m)
    in
    match descend (explode s, t) with
    | None -> false
    | Some _ -> true

let iter f t =
    let rec descend acc sofar = function
        | Empty as node -> f acc sofar node
        | Node (opt, c, l, m, r) as node ->
            let leftacc = descend acc sofar l in
            let newacc = f leftacc sofar node in
            let midacc = descend newacc (c :: sofar) m in
            let rightacc = descend midacc sofar m in
            rightacc
    in List.rev @@ descend [] [] t

let to_key chars =
    let len = List.length chars in
    let bytes = Bytes.create len in
    List.iteri (fun i c -> Bytes.set bytes (len - i - 1) c) chars ;
    Bytes.to_string bytes

let keys t =
    let f acc sofar = function
        | Empty -> acc
        | Node (opt, _, _, _, _) -> (
            match opt with
            | None -> acc
            | Some _ -> to_key sofar :: acc
        )
    in
    iter f t

let items t =
    let f acc sofar = function
        | Empty -> acc
        | Node (opt, _, _, _, _) -> (
            match opt with
            | None -> acc
            | Some v -> (to_key sofar, v) :: acc
        )
    in
    iter f t

