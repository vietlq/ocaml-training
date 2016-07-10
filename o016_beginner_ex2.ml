let isupper (s : string) : bool =
    let length = String.length s in
    let rec loop i =
        if i < length then
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

let period (s : string) : string =
    let length = String.length s in
    match String.get s (length - 1) with
    | '.' -> s
    | _ -> Printf.sprintf "%s." s
;;

Printf.printf "period 'Misha' = %s\n" (period "Misha") ;;
Printf.printf "period 'Misha.' = %s\n" (period "Misha.") ;;

let string_find (c : char) (s : string) : int =
    let length = String.length s in
    let rec loop i =
        if i < length then
            let a = String.get s i in
            if a = c then i
            else loop (i + 1)
        else -1
    in loop 0 ;;

Printf.printf "string_find 'b' 'Misha' = %d\n" (string_find 'b' "Misha") ;;
Printf.printf "string_find 'u' 'Super duper dog' = %d\n" (string_find 'u' "Super duper dog") ;;

type case = Same | Upper | Lower

let cowboy (s : string) : string =
    let bytes = Bytes.of_string s in
    let upper c = Char.uppercase_ascii c in
    let lower c = Char.lowercase_ascii c in
    let length = String.length s in
    let rec loop i case =
        if i < length then
            let cc = String.get s i in
            match cc with
            | 'a'..'z' | 'A'..'Z' ->
                let fcase, thiscase = match case with
                | Same | Lower -> upper, Upper
                | Upper -> lower, Lower
                in Bytes.set bytes i (fcase cc) ;
                loop (i + 1) thiscase
            | _ -> loop (i + 1) Same
    in loop 0 Same ;
    Bytes.to_string bytes
;;

Printf.printf "cowboy 'Hey there! Programming is fun!' = %s\n" (cowboy "Hey there! Programming is fun!") ;;

