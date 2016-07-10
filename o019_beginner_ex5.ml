(* Bounds for array of floats *)
let min arr =
    Array.fold_left (fun m x -> if x < m then x else m) infinity arr
;;
let max arr =
    Array.fold_left (fun m x -> if x > m then x else m) neg_infinity arr
;;
let bounds arr = (min arr, max arr)
;;

let arr1 = [| -2.; 3.; 10.; -6.; 14.; 21.; 5. |] ;;
let bounds1 = bounds arr1 ;;
Printf.printf "bounds [| -2.; 3.; 10.; -6.; 14.; 21.; 5. |] = (%g, %g)\n"
    (fst bounds1) (snd bounds1) ;;

let print_array_float arr =
    let printer x = Printf.printf "%g; " x in
    Array.iter printer arr ;
    print_endline ""
;;

(* Normalize *)
let normalize arr =
    let min, max = bounds arr in
    let dist = max -. min in
    let mapf x = (x -. min) /. dist in
    Array.map mapf arr
;;

let normalized_arr1 = normalize arr1 ;;
print_array_float arr1 ;;
print_array_float normalized_arr1 ;;

