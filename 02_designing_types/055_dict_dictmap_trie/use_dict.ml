let print_usage () =
    print_endline "\n--------------------------------" ;
    print_endline "Usage:\n" ;
    print_endline "* present <word> :\n\tCheck if a <word> is in the dictionary." ;
    print_endline "* insert <word> [<word2> ...] :\n\tInsert word(s) into the dictionary." ;
    print_endline "* exit :\n\tQuit the program." ;
    print_endline "--------------------------------"

let rec main dict =
    print_string "\n> " ;
    match Str.(split (regexp "[ \t]+") (read_line ())) with
    | command :: args -> (
        match command, args with
        | "present", [word] ->
            print_endline (if Dict.present word dict then "Present." else "Not present.") ;
            main dict
        | "insert", (word :: _ as words) ->
            let dict = List.fold_right Dict.insert words dict in
            print_endline "Added." ;
            main dict
        | "exit", [] -> print_endline "Bye."
        | _, _ -> print_usage () ; main dict
    )
    | exception End_of_file -> print_endline "Bye."
    | _ -> print_usage () ; main dict

let () =
    print_usage () ;
    main Dict.empty

