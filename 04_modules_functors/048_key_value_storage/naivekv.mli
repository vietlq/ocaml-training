val init : string -> unit
val put : string -> 'a -> ('a -> string) -> string -> unit
val get : string -> (string -> 'a) -> string -> 'a
