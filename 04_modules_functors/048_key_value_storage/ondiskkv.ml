(*
 * A simple implementation of (key x value) on-disk database is provided here.
 * One file for each key.
 * String data stored as is.
 * Converters to_string/of_string provided for polymorphism
*)

type 'a table = {
    to_string : 'a -> string ;
    of_string : string -> 'a ;
    dir       : string
}

(* Create a directory with permissions 0750 *)
let init to_string of_string dir =
    Unix.mkdir dir 0o750 ;
    { to_string ; of_string ; dir }

(* Save a key-value pair as a file named as key and contents as value *)
let put k v { to_string ; dir } =
    let fp = open_out (Filename.concat dir k) in
    output_string fp (to_string v) ;
    close_out fp

(* Query the value of the key k *)
let get k { of_string ; dir } =
    let fn = Filename.concat dir k in
    if not (Sys.file_exists fn) then raise Not_found ;
    let fp = open_in fn in
    let len = in_channel_length fp in
    let buf = Bytes.create len in
    really_input fp buf 0 len ;
    close_in fp ;
    of_string (Bytes.to_string buf)

