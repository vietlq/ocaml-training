let string_explode s =
    let length = String.length s in
    let rec loop i acc =
        if i < length  then
            loop (i + 1) (String.get s i :: acc)
        else
            acc
    in List.rev (loop 0 [])
;;

let print_list_char lc =
    let printer c = Printf.printf "'%c';" c in
    List.iter printer lc ;
    print_endline ""
;;

print_list_char (string_explode "Programming") ;;

(* Split a string into a list of substrings separated by a delimiter c *)

let string_split c s =
    let length = String.length s in
    let rec loop i acc =
        if i < length then
            match String.index_from s i c with
            | (idx: int) -> 
                let len = idx - i in
                loop (idx + 1) (String.sub s i len :: acc)
            | exception Not_found ->
                let len = length - i in
                String.sub s i len :: acc
        else
            acc
    in List.rev (loop 0 [])
;;

let print_list_string ls =
    let printer s = Printf.printf "\"%s\"; " s in
    List.iter printer ls ;
    print_endline ""
;;

let string2 = "I think programming is super fun! Find radiiii here!" ;;
let stringlist = string_split 'i' string2 ;;
print_list_string stringlist ;; 

(* Join all strings in a list by a delimiter *)
let string_concat c ls =
    let sep = Bytes.make 1 c in
    let byteslist = List.map Bytes.of_string ls in
    let bytes = Bytes.concat sep byteslist in
    Bytes.to_string bytes
;;

Printf.printf "string_concat 'i' stringlist = %s\n"
    (string_concat 'i' stringlist) ;;

let rec string_concat2 sep ls =
    match ls with
    | [] -> ""
    | [s] -> s
    | s1 :: s2 :: tl -> s1 ^ sep ^ string_concat2 sep (s2 :: tl)
;;

Printf.printf "string_concat2 'i' stringlist = %s\n"
    (string_concat2 "i" stringlist) ;;

