type 'a nlist = Nnil | Ncons of int * 'a * 'a nlist

let nlist_length = function
    | Nnil -> 0
    | Ncons (n, _, _) -> n

let nlist_cons a = function
    | Nnil -> Ncons (1, a, Nnil)
    | Ncons (n, _, _) as tl -> Ncons (n + 1, a, tl)

let nlist_rev nlist =
    let rec rev acc = function
        | Nnil -> acc
        | Ncons (_, a, tl) -> rev (nlist_cons a acc) tl
    in
    rev Nnil nlist

let nlist_append nlist1 nlist2 =
    let rev_nlist1 = nlist_rev nlist1 in
    let rec join nlist = function
        | Nnil -> nlist
        | Ncons (_, a, tl) -> join (nlist_cons a nlist) tl
    in join nlist2 rev_nlist1

