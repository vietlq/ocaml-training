(*
 * This file uses Zipper for file processing:
     * Remove empty lines
     * Wrap lines longer than 80 chars
*)

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
            in
            aux zipper
        )
    in
    aux @@ Zipper.fresh zipper

let split_by_len width s =
    let len = String.length s in
    let rec aux acc total nleft =
        if nleft < width then
            (String.sub s total nleft :: acc)
        else
            aux (String.sub s total width :: acc)
                (total + width) (nleft - width)
    in
    (len, List.rev @@ aux [] 0 len)

let rec insert_lines_before lines zipper =
    match lines with
    | [] -> zipper
    | x :: lines ->
        Zipper.insert_before x zipper
        |> insert_lines_before lines

let wrap_cols width zipper =
    let rec aux zipper =
        match Zipper.next zipper with
        | None -> Zipper.fresh zipper
        | Some s -> (
            let len, lines = split_by_len width s in
            let zipper =
                if len <= width then
                    Zipper.move_right zipper
                else
                    Zipper.delete_after zipper
                    |> insert_lines_before lines
            in
            aux zipper
        )
    in
    aux @@ Zipper.fresh zipper

let wrap_lines width do_wrap zipper =
    if do_wrap then
        wrap_cols width zipper
    else
        zipper

let remove_empty_lines file_in file_out do_wrap =
    read_lines file_in
    |> Zipper.of_list
    |> remove_empty_elems
    |> wrap_lines 80 do_wrap
    |> Zipper.to_list
    |> write_lines file_out

let main () =
    let file_in = ref ":Invalid_file:" in
    let file_out = ref ":Invalid_file:" in
    let do_wrap = ref false in
    let usage_msg = "Remove empty lines from a file and write output to another file:\n" in
    let speclist = [
        ("-i", Arg.Set_string file_in, "Input file") ;
        ("-o", Arg.Set_string file_out, "Output file") ;
        ("-w", Arg.Set do_wrap, "Wrap lines longer than 80 chars") ;
    ]
    in
    Arg.parse speclist print_endline usage_msg ;
    if Sys.file_exists !file_in then
        remove_empty_lines !file_in !file_out !do_wrap
    else
        Arg.usage speclist usage_msg

let () = main ()

