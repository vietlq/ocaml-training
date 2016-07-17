let rec echo_non_tail () =
    try
        let line = read_line () in
        if line = "exit" then raise Exit ;
        Printf.printf "%s\n" line ;
        echo_non_tail ()
    with
    | End_of_file -> ()
    | Exit -> print_endline "Bye." ; ()
;;

let rec echo () =
    match read_line () with
    | "exit" -> print_endline "Bye."
    | line -> Printf.printf "%s\n" line ; echo ()
    | exception End_of_file -> ()
;;

echo () ;;
