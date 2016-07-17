type 'a bin = Bnil | Bnode of 'a bin * 'a * 'a bin

(* Verify if a binary tree is a binary search tree *)
exception Not_well_formed

(* Return an empty node *)
let empty = Bnil

(* Infix, non-tail recursive *)
let rec to_list = function
    | Bnil -> []
    | Bnode (left, a, right) -> to_list left @  a :: to_list right

(* Infix, tail-recursive *)
let to_list_tail bin =
    let rec aux acc = function
        | Bnil -> acc
        | Bnode (left, a, right) ->
            aux (a :: (aux acc left)) right
    in List.rev (aux [] bin)

(* Generic prefix traversal *)
let rec prefix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> prefix f (prefix f (f acc a) left) right

(* Generic infix traversal *)
let rec infix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> infix f (f (infix f acc left) a) right

(* Generic postfix traversal *)
let rec postfix f acc = function
    | Bnil -> acc
    | Bnode (left, a, right) -> f (postfix f (postfix f acc left) right) a

(* Traverse infix and apply function f *)
let rec iter f = function
    | Bnil -> ()
    | Bnode (left, a, right) -> iter f left ; f a ; iter f right

let valid_search_tree =
    let rec aux = function
    | Bnil -> assert false (* Never reaches here *)
    | Bnode (Bnil, a, Bnil) -> (a, a)
    | Bnode (left, a, Bnil) ->
        let (lmin, lmax) = aux left in
        if a < lmax then raise Not_well_formed else (lmin, a)
    | Bnode (Bnil, a, right) ->
        let (rmin, rmax) = aux right in
        if a > rmin then raise Not_well_formed else (a, rmax)
    | Bnode (left, a, right) ->
        let lmin, _ = aux (Bnode (left, a, Bnil)) in
        let _, rmax = aux (Bnode (Bnil, a, right)) in
        (lmin, rmax)
    in
    function
        | Bnil -> true
        | t -> try ignore (aux t) ; true with Not_well_formed -> false

(* Write insert function to create a binary search tree *)
let rec insert value = function
    | Bnil -> Bnode (Bnil, value, Bnil)
    | Bnode (left, a, right) when value < a -> Bnode (insert value left, a, right)
    | Bnode (left, a, right) when value > a -> Bnode (left, a, insert value right)
    | n -> n

let rec print_int_node = function
    | Bnil -> ()
    | Bnode (left, a, right) -> (
        print_string "[ " ;
        print_int_node left ;
        Printf.printf " <%d> " a ;
        print_int_node right ;
        print_string " ]"
    )

