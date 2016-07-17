(* Options *)
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

(* Options - hd & tl *)
let hd l =
    match l with
    | [] -> None
    | x :: xs -> Some x ;;
let tl l =
    match l with
    | [] -> None
    | x :: xs -> Some xs ;;

(* Option default *)
let option_default default anopt =
    match anopt with
    | None -> default
    | Some x -> x ;;

let option_map f anopt =
    match anopt with
    | None -> None
    | Some x -> Some (f x) ;;

(* Extract only valus of options that are present *)
let present l =
    let rec loop l acc =
        match l with
        | [] -> acc
        | x :: xs ->
            match x with
            | None -> loop xs acc
            | Some n -> loop xs (n :: acc)
    in loop l [] ;;

let rec present2 = function
    | Some x :: xs -> x :: present2 xs
    | None :: xs -> present2 xs
    | [] -> [] ;;

(* Extract the n-th element if available *)
let nth l n =
    if n < 0 then
        failwith "Negative index not allowed"
    else
        let rec loop l i =
            match l with
            | [] -> None
            | x :: xs ->
                if i = (n - 1) then
                    Some x
                else
                    loop xs (i + 1)
        in loop l 0 ;;

let rec list_nth n = function
    | h :: _ when n = 0 -> Some h
    | _ :: t -> list_nth (n - 1) t
    | [] -> None ;;

