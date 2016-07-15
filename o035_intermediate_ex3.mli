type 'a bin
exception Not_well_formed
val to_list : 'a bin -> 'a list
val iter : ('a -> 'b) -> 'a bin -> unit
val valid_search_tree : 'a bin -> bool
val insert : 'a -> 'a bin -> 'a bin
