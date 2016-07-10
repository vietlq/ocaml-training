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

