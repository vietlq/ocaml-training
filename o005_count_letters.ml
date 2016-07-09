let count s =
    let len = String.length s in
    let rec loop i =
        if i = len then 0
        else
            let letter =
                let c = String.get s i in
                (c >= 'a' && c <= 'z')
                || (c >= 'A' && c <= 'Z') in
            (if letter then 1 else 0) + loop (i + 1) in
    loop 0 ;;

Printf.printf "count = %d\n%!" (count (read_line ()));;
