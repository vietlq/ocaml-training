let count s =
    let is_alpha c = match c with
    | 'a'..'z' -> true
    | 'A'..'Z' -> true
    | _ -> false
    in
    let len = String.length s in
    let rec loop i total =
        if i = len then total
        else
            let c = String.get s i in
            let total = total + (if (is_alpha c) then 1 else 0) in
            loop (i + 1) total in
    loop 0 0 ;;

Printf.printf "count = %d\n%!" (count (read_line ()));;
