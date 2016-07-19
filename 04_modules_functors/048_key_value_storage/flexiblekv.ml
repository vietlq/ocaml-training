module type TABLE = sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
end

module On_disk_table : TABLE = struct
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
end

module In_memory_table : TABLE = struct
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
end

module Cache_table : TABLE = struct
    type 'a table = 'a On_disk_table.table * 'a In_memory_table.table

    let init to_string of_string dir =
        let ondisk = On_disk_table.init to_string of_string dir in
        let inmemory = In_memory_table.init to_string of_string dir in
        (ondisk, inmemory)

    let put k v (ondisk, inmemory) =
        In_memory_table.put k v inmemory ;
        On_disk_table.put k v ondisk

    let get k (ondisk, inmemory) =
        match In_memory_table.get k inmemory with
        | v -> v
        | exception Not_found ->
            match On_disk_table.get k ondisk with
            | exception Not_found -> raise Not_found
            | v ->
                In_memory_table.put k v inmemory ;
                v
end

