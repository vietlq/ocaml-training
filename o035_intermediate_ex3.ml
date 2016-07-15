type 'a bin = Bnil | Bnode of 'a bin * 'a * 'a bin

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

(* Verify if a binary tree is a binary search tree *)
exception Not_well_formed

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
;;

let rec print_int_node = function
    | Bnil -> ()
    | Bnode (left, a, right) -> (
        print_string "[ " ;
        print_int_node left ;
        Printf.printf " <%d> " a ;
        print_int_node right ;
        print_string " ]"
    )
;;

let rec print_int_list l =
    print_string "[ " ;
    List.iter (Printf.printf "%d; ") l ;
    print_string " ]\n"
;;

let print_split () = print_endline "\n----------------" ;;

let make_leaf a = Bnode (Bnil, a, Bnil) ;;
let make_node left a right = Bnode (left, a, right) ;;

let tree1 = (make_node (make_node (make_leaf 4) 2 Bnil) 1 (make_node (make_leaf 5) 3 (make_leaf 6))) ;;
let tree2 = (make_node (make_node (make_leaf 1) 2 Bnil) 3 (make_node (make_leaf 4) 5 (make_leaf 6))) ;;

let aux_print () = Printf.printf "%d ;" ;;

print_int_list (to_list tree1) ;
print_int_list (to_list_tail tree1) ;
print_split () ;
print_int_list (to_list tree2) ;
print_int_list (to_list_tail tree2) ;
print_split () ;
prefix aux_print () tree1 ;
print_split () ;
infix aux_print () tree1 ;
print_split () ;
postfix aux_print () tree1 ;
print_split () ;
Printf.printf "valid_search_tree tree1 = %b\n" (valid_search_tree tree1) ;
Printf.printf "valid_search_tree tree2 = %b\n" (valid_search_tree tree2) ;
print_split () ;;

(* Write insert function to create a binary search tree *)
let rec insert value = function
    | Bnil -> make_leaf value
    | Bnode (left, a, right) as t ->
        if value < a then
            Bnode (insert value left, a, right)
        else
            if value > a then
                Bnode (left, a, insert value right)
            else
                t
;;

let tree3 = insert 4 Bnil ;;
print_int_node tree3 ; print_endline "" ;;
let tree3 = insert 3 tree3 ;;
print_int_node tree3 ; print_endline "" ;;
let tree3 = insert 2 tree3 ;;
print_int_node tree3 ; print_endline "" ;;
let tree3 = insert 5 tree3 ;;
print_int_node tree3 ; print_endline "" ;;
let tree3 = insert 6 tree3 ;;
print_int_node tree3 ; print_endline "" ;;
let tree3 = insert 1 tree3 ;;
print_int_node tree3 ; print_endline "" ;;


