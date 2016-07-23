type dict = Empty | Node of bool * (char * dict) list
val empty : dict
val present : string -> dict -> bool
