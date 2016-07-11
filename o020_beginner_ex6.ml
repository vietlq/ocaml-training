let string_find (c : char) (s : string) =
    let len = String.length s in
    let rec loop i =
        if i < len then
            if s.[i] = c then Some i
            else loop (i + 1)
        else None
    in loop 0
;;

Printf.printf "string_find 'z' 'Awesome ice-cream!' = None -> %b\n"
    ((string_find 'z' "Awesome ice-cream!") = None) ;;
Printf.printf "string_find 'A' 'Awesome ice-cream!' = Some 0 -> %b\n"
    ((string_find 'A' "Awesome ice-cream!") = Some 0) ;;
Printf.printf "string_find 'm' 'Awesome ice-cream!' = Some 5 -> %b\n"
    ((string_find 'm' "Awesome ice-cream!") = Some 5) ;;

