let now =
    Unix.gettimeofday() ;;
let ask () =
    print_endline ("Now is " ^ string_of_float now ^ ".") ;
    print_endline "Is it too early for a beer?" ;
    ignore (read_line()) ;
    print_endline "It's always time for a beer!" ;;
ask () ;;
