open Bintree ;;

let rec print_int_list l =
    print_string "[ " ;
    List.iter (Printf.printf "%d; ") l ;
    print_string " ]\n"
;;

let print_split () = print_endline "\n----------------"

let tree1 = (insert 1 (insert 6 (insert 5 (insert 2 (insert 3 (insert 4 empty)))))) ;;

let list1 = to_list tree1 ;;
assert (list1 = [1; 2; 3; 4; 5; 6]) ;;
print_int_list list1 ;;
print_split () ;;

(* Take a list, and return resulting list in sorted mode *)
let list_sort_unique l =
    to_list @@ List.fold_left (fun a b -> insert b a) empty l ;;

let list2 = [ 2; -5; 2; -5; 7; -10; 0; 5; 32 ] ;;
let list3 = list_sort_unique list2 ;;
assert (list3 = [-10; -5; 0; 2; 5; 7; 32]) ;;
print_int_list list2 ;;
print_int_list list3 ;;

