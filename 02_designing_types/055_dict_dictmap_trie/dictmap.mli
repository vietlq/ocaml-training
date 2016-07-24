type 'a dictmap
val empty : 'a dictmap
val set : string -> 'a -> 'a dictmap -> 'a dictmap
val get : string -> 'a dictmap -> 'a
val present : string -> 'a dictmap -> bool
