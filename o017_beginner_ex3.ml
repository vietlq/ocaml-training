let cube x = x * x * x ;;
let cubes l = List.map cube l ;;

let print_int_list l =
    let printer i = Printf.printf "%d; " i in
    List.iter printer l ;
    print_endline ""
;;

let alist = [5; -4; 10; 23] ;;
print_int_list alist ;;
print_int_list (cubes alist) ;;

