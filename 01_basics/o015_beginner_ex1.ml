let cube x = x * x * x ;;

let mean x y = (x +. y) /. 2. ;;

let max x y = if x > y then x else y ;;

let positive_part (a : float) : float =
    let full_part a = float_of_int (int_of_float a) in
    if a > 0. then
        a -. (full_part a)
    else
        a -. (full_part a) +. 1.
;;

Printf.printf "positive_part (-3.2) = %f\n" (positive_part (-3.2)) ;;

let sizeof_int =
    let rec loop num bits =
        if num > 0 then loop (num/2) (bits+1)
        else bits
    in (loop max_int 0) + 1
    (* The extra 1 is due to the fact that there are the same number of negative integers *)
;;

Printf.printf "sizeof_int = %d\n" sizeof_int ;;

let rec ones num =
    match num with
    | 0 -> 0
    | 1 | 2 | 4 | 8 -> 1
    | 3 | 5 | 9 | 6 | 10 | 12 -> 2
    | 7 | 11 | 13 | 14 -> 3
    | 15 -> 4
    | num -> (ones (num / 16)) + (ones (num mod 16))
;;

Printf.printf "ones 1001 = %d\n" (ones 1001) ;;

(* Start from 1 and shift left until we overflow *)
let sizeof_int2 =
    let rec shift n =
        if (n + n) <= n then 1 else 1 + shift (n + n)
    in shift 1 + 1 ;;

Printf.printf "sizeof_int2 = %d\n" sizeof_int2 ;;

(* Do bit and with 1 and shift right, keep doing until we can't shift *)
let rec ones2 n =
    if n = 0 then 0 else n land 1 + ones (n lsr 1) ;;

Printf.printf "ones2 1001 = %d\n" (ones2 1001) ;;
