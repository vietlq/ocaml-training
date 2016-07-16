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

let file_size path =
    let open Unix in
    let { st_kind ; st_size } = Unix.stat path in
    if st_kind = Unix.S_REG then st_size else 0

let read_file path =
    match file_size path with
    | 0 -> ""
    | size when size < 0 ->
        Printf.eprintf "The file <%s> has negative size = %d\n" path size ;
        ""
    | size -> (
        let size = min size 256 in
        let bytes = Bytes.create size in
        let in_channel = open_in path in
        match really_input in_channel bytes 0 size with
        | () -> Bytes.to_string bytes
        | exception Invalid_argument _ ->
            Printf.eprintf "Could not read %d bytes from the file <%s>\n" size path ;
            ""
    )

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
                    let text = read_file path in
                    Array.append contents [| File (inode, text) |]
                | true -> (
                    Array.append contents
                        [| Dir (inode, add_items path [||] (Sys.readdir path)) |]
                )
            in Array.fold_left process contents items
        in Dir (dir_path, add_items dir_path [||] items)

