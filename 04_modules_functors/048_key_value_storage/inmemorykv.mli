type 'a table
val init : ('a -> string) -> (string -> 'a) -> 'b -> 'a table
val put : string -> 'a -> 'a table -> unit
val get : string -> 'a table -> 'a
