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

(* Reverse array in place *)
let array_rev_in_place arr =
    let length = Array.length arr in
    for i = 0 to (length / 2) do
        let bak = arr.(i) in
        arr.(i) <- arr.(length - i - 1) ;
        arr.(length - i - 1) <- bak
    done
;;

array_rev_in_place arr1 ;;
print_array_float arr1 ;;

(* Transpose square 2D matrix in place *)
let transpose_square_mat mat =
    let rows = Array.length mat in
    let cols = Array.length mat.(0) in
    for i = 0 to (rows - 2) do
        for j = (i + 1) to (cols - 1) do
            let bak = mat.(i).(j) in
            mat.(i).(j) <- mat.(j).(i) ;
            mat.(j).(i) <- bak
        done
    done
;;

let print_array_int arr =
    print_string "  [|" ;
    Array.iter (Printf.printf "%4d; ") arr ;
    print_endline "|];"
;;
let print_matrix_int mat =
    print_endline "[|" ;
    Array.iter print_array_int mat ;
    print_endline "|]"
;;

let gen_array_int elems min max =
    if min > max then
        failwith "Invalid input: min > max"
    else
        let gen () = Random.int (max - min) + min in
        let arr = Array.make elems 0 in
        for i = 0 to (elems - 1) do
            arr.(i) <- gen ()
        done ;
        arr
;;

let gen_matrix_int rows cols min max =
    if min > max then
        failwith "Invalid input: min > max"
    else
        let gen () = Random.int (max - min) + min in
        let mat = Array.make_matrix rows cols 0 in
        for i = 0 to (rows - 1) do
            for j = 0 to (cols - 1) do
                mat.(i).(j) <- gen ()
            done
        done ;
        mat
;;

(*
 * For testing purposes, do not init the seed
 * Random.self_init () ;;
*)

let mat1 = gen_matrix_int 5 5 (-42) 72 ;;
print_matrix_int mat1 ;;
transpose_square_mat mat1 ;;
print_matrix_int mat1 ;;

(* Histogram of chars *)
let string_stats (s : string) =
    let arr = Array.make 256 0 in
    for i = 0 to (String.length s - 1) do
        let code = Char.code (String.get s i) in
        arr.(code) <- 1 + arr.(code)
    done ;
    arr
;;

let string2 = "Array.make n x returns a fresh array of length n, initialized with x. All the elements of this new array are initially physically equal to x (in the sense of the == predicate). Consequently, if x is mutable, it is shared among all elements of the array, and modifying x through one of the array entries will modify all other entries at the same time.\n" ;;

print_string string2 ;;
let stats = string_stats string2 ;;
print_array_int stats ;;


