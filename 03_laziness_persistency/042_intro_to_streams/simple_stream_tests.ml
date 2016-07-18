open Simple_stream ;;

(*
 * Play with some functions:
     * to_list (take 10 naturals)
     * to_list (take 10 squares)
     * to_list (take 10 odd_nums)
     * to_list (take 10 fibs)
     * to_list (take 10 (drop 10 fibs))
*)

(* The infinite stream of all natural numbers *)
let rec naturals = lazy (Cons (1, map succ naturals))

(* The infinite stream of square numbers *)
let squares = map (fun x -> x * x) naturals

(* The infinite stream of odd numbers *)
let odd_nums = map (fun x -> 2 * x - 1) naturals

(* The infinite stream of Fibobacci numbers *)
let rec fibs =
    lazy (Cons (1, lazy (Cons (1, map2 (+) fibs (tail fibs)))))

(* The 11th-20th Fibonacci numbers *)
let fibs_11_20 = take 10 (drop 10 fibs)

let print_int_list l =
    print_string "[ " ;
    List.iter (Printf.printf "%d; ") l ;
    print_endline "]"

let () =
    print_string "\n(to_list (take 10 naturals)) = \n\t" ;
    print_int_list (to_list (take 10 naturals)) ;
    print_string "\n(to_list (take 10 squares)) = \n\t" ;
    print_int_list (to_list (take 10 squares)) ;
    print_string "\n(to_list (take 10 odd_nums)) = \n\t" ;
    print_int_list (to_list (take 10 odd_nums)) ;
    print_string "\n(to_list (take 10 fibs)) = \n\t" ;
    print_int_list (to_list (take 10 fibs)) ;
    print_string "\n(to_list (take 10 (drop 10 fibs))) = \n\t" ;
    print_int_list (to_list (take 10 (drop 10 fibs)))

