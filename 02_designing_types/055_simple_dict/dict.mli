type dict = Empty | Node of bool * (char * dict) list
val empty : dict
