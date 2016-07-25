type 'a tst
val empty : 'a tst
val set : string -> 'a -> 'a tst -> 'a tst
val get : string -> 'a tst -> 'a
val present : string -> 'a tst -> bool
val iter : ('a list -> char list -> 'b tst -> 'a list) -> 'b tst -> 'a list
