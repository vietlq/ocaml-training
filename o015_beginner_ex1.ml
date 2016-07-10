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

