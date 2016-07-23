type dict = Empty | Node of bool * (char * dict) list

let empty = Empty

let explode s =
    let len = String.length s in
    let rec aux acc n =
        if n >= len then acc
        else
            aux (s.[n] :: acc) (n + 1)
    in
    aux [] 0

