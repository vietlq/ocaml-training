type 'a vfs = Nil | File of string * 'a | Dir of string * 'a vfs array

let print_vfs vfs =
    let rec aux prefix = function
        | Nil -> ()
        | File (name, _) -> print_endline (prefix ^ "/" ^ name)
        | Dir (name, contents) ->
            print_endline (prefix ^ "/" ^ name ^ " = [") ;
            Array.iter (aux ("  " ^ prefix)) contents ;
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
            Array.iter (aux ("  " ^ prefix)) contents ;
            print_endline (prefix ^ "]")
    in aux "" vfs

let read_dir dir_path =
    match Sys.is_directory dir_path with
    | false -> failwith "Invalid directory path"
    | true ->
        let items = Sys.readdir dir_path in
        let rec add_items prefix contents items =
            let process contents inode =
                let path = prefix ^ "/" ^ inode in
                match Sys.is_directory path with
                | false ->
                    Array.append contents [| File (inode, "") |]
                | true -> (
                    Array.append contents
                        [| Dir (inode, add_items path [||] (Sys.readdir path)) |]
                )
            in Array.fold_left process contents items
        in Dir (dir_path, add_items dir_path [||] items)

