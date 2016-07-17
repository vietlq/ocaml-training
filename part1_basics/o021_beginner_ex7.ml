(* Print a list of strings using different techniques *)
let print_string_list ls =
    List.iter print_endline ls ;;

let print_string_list2 ls =
    for i = 0 to (List.length ls) do
        print_endline (List.nth ls i)
    done ;;

let print_string_list3 ls =
    let count = ref 0 in
    while !count < (List.length ls) do
        print_endline (List.nth ls !count) ;
        count := !count + 1
    done ;;

let print_string_list3 ls =
    let tl = ref ls in
    while !tl <> [] do
        print_endline (List.hd !tl) ;
        tl := List.tl !tl
    done ;;

(* Print a banner *)
let print_banner width (s : string) =
    let len = String.length s in
    let total_len = len + 2 in
    if total_len > width then
        failwith "The screen is not wide enough"
    else
        let start = (width - total_len)/2 in
        let print_buffer = String.make start ' ' in
        let header = String.make len '-' in
        let print_header () = print_endline (print_buffer ^ "+" ^ header ^ "+") in
        let print_content () = print_endline (print_buffer ^ "|" ^ s ^ "|") in
        print_header () ;
        print_content () ;
        print_header ()
;;

print_banner 70 "Hello World" ;;

(* Print bar graph *)
let min vals =
    Array.fold_left (fun n x -> if x < n then x else n) infinity vals ;;
let max vals =
    Array.fold_left (fun n x -> if x > n then x else n) neg_infinity vals ;;

let bar_graph vals maxh =
    let minv, maxv = min vals, max vals in
    if minv < 0.0 || maxv > 1.0 then
        failwith "Out of range [0; 1]. Normalize first"
    else
        let height aval =
            int_of_float ((aval *. (float_of_int maxh)) /. maxv)
        in
        let heights = Array.map height vals in
        let printer level height =
            if level < height then
                print_string "# "
            else
                print_string "  "
        in
        let print_level level () =
            Array.iter (printer level) heights ;
            print_endline ""
        in
        for level = (maxh - 1) downto 0 do
            print_level level ()
        done
;;

(* Normalize *)
let normalize arr =
    let min, max = min arr, max arr in
    let dist = max -. min in
    let mapf x = (x -. min) /. dist in
    Array.map mapf arr
;;

(* Histogram of chars *)
let string_stats (s : string) =
    let arr = Array.make 256 0 in
    for i = 0 to (String.length s - 1) do
        let code = Char.code (String.get s i) in
        arr.(code) <- 1 + arr.(code)
    done ;
    arr
;;

(* Find occurences of specified characters in a string *)
let occurences (s : string) chars =
    let stats = string_stats s in
    let len = Array.length chars in
    let arr = Array.make len 0 in
    for i = 0 to (len - 1) do
        let code = Char.code chars.(i) in
        arr.(i) <- stats.(code)
    done ;
    arr
;;

let display_occurences (s : string) labels =
    let vals = occurences s labels in
    let fvals = Array.map float_of_int vals in
    let nvals = normalize fvals in
    let maxh = 20 in
    let () = bar_graph nvals maxh in
    Array.iter (Printf.printf "%c ") labels ;
    print_endline ""
;;

let string2 = "Array.make n x returns a fresh array of length n, initialized with x. All the elements of this new array are initially physically equal to x (in the sense of the == predicate). Consequently, if x is mutable, it is shared among all elements of the array, and modifying x through one of the array entries will modify all other entries at the same time.\n" ;;

let () = display_occurences string2 [| 'a'; 'e'; 'd'; 't'; 'c' |] ;;

