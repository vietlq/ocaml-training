module type TABLE =
  sig
    type 'a table
    type param
    val init : ('a -> string) -> (string -> 'a) -> param -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

module On_disk_table : TABLE with type param := string

module In_memory_table : TABLE with type param := unit

module Cache_table : TABLE with type param := string

