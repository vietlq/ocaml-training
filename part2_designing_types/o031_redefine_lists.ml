type 'a list =
    | Nil
    | Cons of 'a * 'a list

let hd = function
    | Nil -> invalid_arg "hd"
    | Cons (hd, _) -> hd

let tl = function
    | Nil -> invalid_arg "tl"
    | Cons (_, tl) -> tl

