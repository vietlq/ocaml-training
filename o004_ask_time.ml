let ask () =
    let now = Unix.gettimeofday () in
    print_endline ("Now is " ^ string_of_float now ^ ".") ;
    print_endline "Is it too early for a beer?" ;
    let _ = read_line () in
    print_endline "It's always time for a beer!" ;;
ask () ;;
