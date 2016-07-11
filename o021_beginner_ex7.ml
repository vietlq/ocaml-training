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
print_banner 20 "Hello World" ;;

