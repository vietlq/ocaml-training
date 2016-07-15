open Bintree ;;

let rec print_int_list l =
    print_string "[ " ;
    List.iter (Printf.printf "%d; ") l ;
    print_string " ]\n"
;;

let print_split () = print_endline "\n----------------"

let tree3 = (insert 1 (insert 6 (insert 5 (insert 2 (insert 3 (insert 4 empty)))))) ;;

print_int_list (to_list tree3) ;;
print_split () ;;

