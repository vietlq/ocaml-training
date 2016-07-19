(*
 * A naive implementation of (key x value) on-disk database is provided here.
 * One file for each key.
 * String data stored as is.
*)

(* Create a directory with permissions 0750 *)
let init dir = Unix.mkdir dir 0o750

(* Save a key-value pair as a file named as key and contents as value *)
let put k v dir =
    let fp = open_out (Filename.concat dir k) in
    output_string fp v ;
    close_out fp

(* Query the value of the key k *)
let get k dir =
    let fn = Filename.concat dir k in
    if not (Sys.file_exists fn) then raise Not_found ;
    let fp = open_in fn in
    let len = in_channel_length fp in
    let buf = Bytes.create len in
    really_input fp buf 0 len ;
    close_in fp ;
    Bytes.to_string buf

(*
 * Save a key-value pair as a file named as key and contents as value.
 * A serializer/converter for more generic interface
*)
let put k v to_string dir =
    let fp = open_out (Filename.concat dir k) in
    output_string fp (to_string v) ;
    close_out fp

(*
 * Query the value of the key k.
 * A deserializer/converter for more generic interface
*)
let get k of_string dir =
    let fn = Filename.concat dir k in
    if not (Sys.file_exists fn) then raise Not_found ;
    let fp = open_in fn in
    let len = in_channel_length fp in
    let buf = Bytes.create len in
    really_input fp buf 0 len ;
    close_in fp ;
    of_string (Bytes.to_string buf)

