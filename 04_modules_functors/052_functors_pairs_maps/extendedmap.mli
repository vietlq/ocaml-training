module Make :
    functor (Ord : Map.OrderedType) ->
        sig
            include Map.S with type 'a t = 'a Map.Make(Ord).t
                and type key = Map.Make(Ord).key
            val of_list : (key * 'a) list -> 'a t
            val keys : 'a t -> Set.Make(Ord).t
        end

