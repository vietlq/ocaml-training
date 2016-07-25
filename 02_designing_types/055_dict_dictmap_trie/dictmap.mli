type 'a dictmap
val empty : 'a dictmap
val set : string -> 'a -> 'a dictmap -> 'a dictmap
val get : string -> 'a dictmap -> 'a
val present : string -> 'a dictmap -> bool
val iter : ('a list -> char list -> 'b dictmap -> 'a list) -> 'b dictmap -> 'a list
val keys : 'a dictmap -> string list
val items : 'a dictmap -> (string * 'a) list
