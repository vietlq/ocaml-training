module On_disk_table :
  sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

module In_memory_table :
  sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

