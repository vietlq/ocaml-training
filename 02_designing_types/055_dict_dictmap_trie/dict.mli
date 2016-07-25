type dict
val empty : dict
val insert : string -> dict -> dict
val present : string -> dict -> bool
val iter : ('a list -> char list -> dict -> 'a list) -> dict -> 'a list
val keys : dict -> string list
