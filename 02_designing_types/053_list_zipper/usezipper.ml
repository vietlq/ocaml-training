let read_lines file =
    let ic = open_in file in
    let rec loop acc =
        match input_line ic with
        | line -> loop (line :: acc)
        | exception End_of_file ->
            close_in ic ;
            List.rev acc
    in
    loop []

let write_lines file lines =
    let oc = open_out file in
    let output_line line =
        output_string oc line ;
        output_char oc '\n'
    in
    List.iter output_line lines ;
    close_out oc

let remove_empty_elems zipper =
    let rec aux zipper =
        match Zipper.next zipper with
        | None -> Zipper.fresh zipper
        | Some x -> (
            let zipper =
                if x = "" then
                    Zipper.delete_after zipper
                else
                    Zipper.move_right zipper
            in aux zipper
        )
    in
    aux @@ Zipper.fresh zipper

let remove_empty_lines file_in file_out =
    read_lines file_in
    |> Zipper.of_list
    |> remove_empty_elems
    |> Zipper.to_list
    |> write_lines file_out

let main () =
    let file_in = ref ":Invalid_file:" in
    let file_out = ref ":Invalid_file:" in
    let usage_msg = "Remove empty lines from a file and write output to another file:\n" in
    let speclist = [
        ("-i", Arg.Set_string file_in, "Input file") ;
        ("-o", Arg.Set_string file_out, "Output file") ;
    ]
    in
    Arg.parse speclist print_endline usage_msg ;
    if Sys.file_exists !file_in then
        remove_empty_lines !file_in !file_out
    else
        Arg.usage speclist usage_msg

let () = main ()

