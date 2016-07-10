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
print_list_string (string_split 'i' string2) ;;

