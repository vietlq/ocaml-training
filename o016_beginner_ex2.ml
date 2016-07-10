let isupper (s : string) : bool =
    let rec loop i =
        if i < String.length s then
            match String.get s i with
            | 'a'..'z' -> false
            | _ -> loop (i + 1)
        else true
    in loop 0
;;

Printf.printf "isupper \"Misha1234\" = %b\n" (isupper "Misha1234") ;;
Printf.printf "isupper \"MISHA1234\" = %b\n" (isupper "MISHA1234") ;;
Printf.printf "isupper \"1234\" = %b\n" (isupper "1234") ;;
Printf.printf "isupper \"\" = %b\n" (isupper "") ;;

