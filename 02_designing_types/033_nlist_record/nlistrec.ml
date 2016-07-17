type 'a nlist = {
    len : int ;
    contents : 'a nlist_content
}
and 'a nlist_content =
    | Empty
    | Node of 'a * 'a nlist_content

let make_nlist (contents : 'a nlist_content) =
    let rec count acc = function
        | Empty -> acc
        | Node (_, tl) -> count (acc + 1) tl
    in
    let len = count 0 contents in
    { len ; contents }

let nlist_length { len } = len

let nlist_cons (a : 'a) { len ; contents } =
    match len, contents with
    | 0, Empty ->
        { len = 1; contents = Node (a, Empty) }
    | len, (Node (_, _) as tl) when len > 0 ->
        { len = (len + 1) ; contents = Node (a, tl) }
    | _, _ -> invalid_arg "nlist_cons"

let nlist_rev { len ; contents } =
    let rec rev acc = function
        | Empty -> acc
        | Node (a, tl) -> rev (Node (a, acc)) tl
    in
    { len ; contents = rev Empty contents }

let nlist_append nlist1 nlist2 =
    let { len ; contents } = nlist_rev nlist1 in
    let rec join nlist = function
        | Empty -> nlist
        | Node (a, tl) -> join (nlist_cons a nlist) tl
    in join nlist2 contents

