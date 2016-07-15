type 'a vfs = Nil | File of string * 'a | Dir of string * 'a vfs list

let print_vfs vfs =
    let rec aux prefix =
        let extra = function
            | "" -> "/"
            | s -> "  " ^ s
        in function
        | Nil -> ()
        | File (name, _) -> print_endline (prefix ^ name)
        | Dir (name, contents) ->
            print_endline (prefix ^ name ^ " = [") ;
            List.iter (aux (extra prefix)) contents
    in aux "" vfs

