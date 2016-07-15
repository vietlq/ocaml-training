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

