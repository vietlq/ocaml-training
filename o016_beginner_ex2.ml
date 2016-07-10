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

(* Hangman game starts here *)
let hangman_init (word : string) : string =
    Bytes.make (String.length word) '_'
;;

Printf.printf "hangman_init 'Programming' = %s\n" (hangman_init "Programming") ;;

let hangman_step (word : string) (partial : bytes) (c : char) : bool =
    let length = String.length word in
    let rec loop i res =
        if i < length then
            let cc = String.get word i in
            let uc = Char.uppercase_ascii c in
            let ucc = Char.uppercase_ascii cc in
            if uc = ucc then
                begin
                    Bytes.set partial i uc ;
                    loop (i + 1) true
                end
            else
                loop (i + 1) res
        else res
    in loop 0 false
;;

let word = "Programming" ;;
let masked = Bytes.of_string (hangman_init word) ;;
let guess word masked chars =
    let printer c =
        Printf.printf "hangman_step word masked '%c' = %b\n" c (hangman_step word masked c) ;
        Printf.printf "masked = %s\n" (Bytes.to_string masked)
    in List.iter printer chars
;;
guess word masked ['c'; 'b'; 'a'; 'r'; 'p'; 'm'; 'i'; 'n'];;

