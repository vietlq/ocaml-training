let cube x = x * x * x ;;
let cubes l = List.map cube l ;;

let print_int_list l =
    let printer i = Printf.printf "%d; " i in
    List.iter printer l ;
    print_endline ""
;;

let print_float_list l =
    let printer i = Printf.printf "%f; " i in
    List.iter printer l ;
    print_endline ""
;;

let alist = [5; -4; 10; 23] ;;
let blist = [5.; -4.; 10.; 23.] ;;
print_int_list alist ;;
print_int_list (cubes alist) ;;

let average l =
    let sum a b = a +. b in
    let total = List.fold_left sum 0. l in
    total /. (float_of_int (List.length l))
;;

Printf.printf "average [5.; -4.; 10.; 23.] = %f\n" (average blist) ;;

