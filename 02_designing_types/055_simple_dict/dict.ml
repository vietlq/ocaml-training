type dict = Empty | Node of bool * (char * dict) list

let empty = Empty

let explode s =
    let rec aux acc n =
        if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
    aux [] (String.length s - 1)

let rec present s d =
    let rec descend = function
        | _, Empty -> false
        | _ :: _, Node (_, []) -> false
        | [], Node (ended, _) -> ended
        | x :: xs as chars , Node (ended, (c, d) :: l) ->
            if x = c then descend (xs, d)
            else descend (chars, Node (ended, l))
    in descend (explode s, d)

