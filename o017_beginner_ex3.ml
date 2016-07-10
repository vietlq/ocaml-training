let cube x = x * x * x ;;
let cubes l = List.map cube l ;;

let print_int_list l =
    let printer i = Printf.printf "%d; " i in
    List.iter printer l ;
    print_endline ""
;;

(* Average *)

let print_float_list l =
    let printer i = Printf.printf "%g; " i in
    List.iter printer l ;
    print_endline ""
;;

let list1 = [5; -4; 10; 23] ;;
let list2 = [5.; -4.; 10.; 23.] ;;
print_int_list list1 ;;
print_int_list (cubes list1) ;;

let average l =
    let sum a b = a +. b in
    let total = List.fold_left sum 0. l in
    total /. (float_of_int (List.length l))
;;

Printf.printf "average [5.; -4.; 10.; 23.] = %g\n" (average list2) ;;

(* Low-pass filter *)
let low_pass_filter l x =
    List.filter ((>=) x) l
;;

let list3 = [10.; 14.; 5.; 7.; 9.; 1.; 2.; 12.;] ;;
print_string "Before low_pass_filter with threshold 9.5:\n" ;;
print_float_list list3 ;;
let list4 = low_pass_filter list3 9.5 ;;
print_string "After low_pass_filter with threshold 9.5:\n" ;;
print_float_list list4 ;;

(* Predicate to detect increasing list *)
let rec increasing l =
    match l with
    | [] | [_] -> true
    | x :: y :: tl ->
        if y < x then false
        else increasing (y :: tl)
;;

Printf.printf "increasing [1;1;2;3;2] = %b\n" (increasing [1;1;2;3;2]) ;;
Printf.printf "increasing [1;1;2;3;4] = %b\n" (increasing [1;1;2;3;4]) ;;
Printf.printf "increasing [1;1;2;3;3] = %b\n" (increasing [1;1;2;3;3]) ;;
Printf.printf "increasing [1;1;1;1;1] = %b\n" (increasing [1;1;1;1;1]) ;;

