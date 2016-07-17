let rec grep_lines rex fp =
    match input_line fp with
    | line ->
            if Re.execp rex line then
                line :: grep_lines rex fp
            else
               grep_lines rex fp
    | exception End_of_file -> [];;

let main () = match Array.to_list Sys.argv with
| exe :: pat :: [] ->
        let rex = Re_posix.compile_pat pat in
        let lines = grep_lines rex stdin in
        List.iter (Printf.printf "%s\n") lines
| exe :: pat :: files ->
        let rex = Re_posix.compile_pat pat in
        List.iter (fun file ->
            let fp = open_in file in
            let lines = grep_lines rex fp in
            List.iter (Printf.printf "%s: %s\n" file) lines;
            close_in fp)
        files
| _ -> Printf.eprintf "%s <regexp> files\n%!"
    Sys.executable_name ;
    exit 1;;

main();;
