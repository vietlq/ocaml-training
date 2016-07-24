type dict = Empty | Node of bool * (char * dict) list
val empty : dict
val explode : string -> char list
val insert : string -> dict -> dict
val present : string -> dict -> bool
