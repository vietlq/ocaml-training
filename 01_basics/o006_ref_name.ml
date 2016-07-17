let ask_for_name rname =
    print_endline ("Would you like to give your name? y/n") ;
    if read_line () = "y" then
        let () = print_string "Input your name: " in
        rname := read_line () ;;
let name = ref (Sys.getenv "USER") ;;
ask_for_name name ;;
print_endline ("Hello " ^ !name);;
