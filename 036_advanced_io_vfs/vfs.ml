type 'a vfs = Nil | File of string * 'a | Dir of string * 'a vfs list

let print_vfs vfs =
    let rec aux prefix = function
        | Nil -> ()
        | File (name, _) -> print_endline (prefix ^ "/" ^ name)
        | Dir (name, contents) ->
            print_endline (prefix ^ "/" ^ name ^ " = [") ;
            List.iter (aux ("  " ^ prefix)) contents ;
            print_endline (prefix ^ "]")
    in aux "" vfs

let print_vfs_chars vfs =
    let rec aux prefix = function
        | Nil -> ()
        | File (name, text) ->
            print_endline (prefix ^ "/" ^ name) ;
            Format.printf "%s  \"@[<hov>" prefix ;
            String.iter (Format.printf "%c@,") text ;
            Format.printf "\"@]@."
        | Dir (name, contents) ->
            print_endline (prefix ^ "/" ^ name ^ " = [") ;
            List.iter (aux ("  " ^ prefix)) contents ;
            print_endline (prefix ^ "]")
    in aux "" vfs

