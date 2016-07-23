type dict = Empty | Node of bool * (char * dict) list

let empty = Empty

let explode s =
    let rec aux acc n =
        if n < 0 then acc
        else aux (s.[n] :: acc) (n - 1)
    in
    aux [] (String.length s - 1)

let rec present s d =
    let rec aux chars = function
        | Empty -> false
        | Node (b, l) -> find b chars l
    and find b chars l =
        match chars, l with
        | _, [] -> false
        | [x], [(c, d)] -> if x = c && b then true else false
        | ((x :: xs) as chars), (c, d) :: l ->
            if x = c then aux xs d
            else find b chars l
        | _, _ -> invalid_arg "present"
    in aux (explode s) d

