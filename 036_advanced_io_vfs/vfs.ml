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

