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

let rec get_aux = function
    | [], _ | _, Empty -> None
    | [x], Node (opt, c, l, _, r) ->
        if x < c then get_aux ([x], l)
        else if x > c then get_aux ([x], r)
        else opt
    | x :: y :: chars, Node (opt, c, l, m, r) ->
        if x < c then get_aux (x :: y :: chars, l)
        else if x > c then get_aux (x :: y :: chars, r)
        else get_aux (y :: chars, m)

let get s t =
    match get_aux (explode s, t) with
    | None -> raise Not_found
    | Some v -> v

let present s t =
    match get_aux (explode s, t) with
    | None -> false
    | Some _ -> true

let iter f t =
    let rec descend acc sofar = function
        | Empty -> acc
        | Node (opt, c, l, m, r) as node ->
            let acc = descend acc sofar l in
            let acc = f acc (c :: sofar) node in
            let acc = descend acc (c :: sofar) m in
            let acc = descend acc sofar r in
            acc
    in List.rev @@ descend [] [] t

let to_key chars =
    let len = List.length chars in
    let bytes = Bytes.create len in
    List.iteri (fun i c -> Bytes.set bytes (len - i - 1) c) chars ;
    Bytes.to_string bytes

let keys t =
    let f acc sofar = function
        | Empty | Node (None, _, _, _, _) -> acc
        | Node (Some _, _, _, _, _) -> to_key sofar :: acc
    in
    iter f t

let items t =
    let f acc sofar = function
        | Empty | Node (None, _, _, _, _) -> acc
        | Node (Some v, _, _, _, _) -> (to_key sofar, v) :: acc
    in
    iter f t

