type 'a table = {
    to_string : ('a -> string) ;
    of_string : (string -> 'a) ;
    table     : (string, string) Hashtbl.t
}

(* Initialize in-memory key-value instance. The value dir is not used *)
let init to_string of_string _ =
    let open Hashtbl in
    let table : (string, string) t = create 100 in
    { to_string ; of_string ; table }

(* Put a key-value pair into the hashtable *)
let put k v { to_string ; table } =
    Hashtbl.replace table k (to_string v)

(* Query the value of the key k from the hashtable *)
let get k { of_string ; table } =
    of_string (Hashtbl.find table k)

(* Note that the dir/name of DB is not used at all. Something to improve *)

