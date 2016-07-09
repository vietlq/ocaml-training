let count s =
    let is_alpha c = match c with
    | 'a'..'z' -> true
    | 'A'..'Z' -> true
    | _ -> false
    in
    let len = String.length s in
    let rec loop i =
        if i = len then 0
        else
            let c = String.get s i in
            (if (is_alpha c) then 1 else 0) + loop (i + 1) in
    loop 0 ;;

Printf.printf "count = %d\n%!" (count (read_line ()));;
