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
