module type ELEMENT = sig
    type t
    val compare : t -> t -> int
end

module type MULTISET = sig
    type t
    type elt
    val empty : t
    val add : elt -> t -> t
    val multiplicity : elt -> t -> int
end

module type MULTISET_FTR = functor (E : ELEMENT) -> MULTISET with type elt = E.t

module MakeMultiSet : MULTISET_FTR =
    functor (E : ELEMENT) ->
        struct
            type elt = E.t

            type t =  (elt * int) list

            let empty = []

            let rec add elt = function
                | [] -> [ (elt, 1) ]
                | (e, m) :: rest when elt = e -> (e, succ m) :: rest
                | (e, _) as p :: rest when elt > e -> (elt, 1) :: p :: rest
                | p :: rest -> p :: add elt rest

            let rec multiplicity elt = function
                | [] -> 0
                | (e, _) :: rest when elt > e -> 0
                | (e, m) :: rest when elt = e -> m
                | _ :: rest -> multiplicity elt rest
        end

module Make_multiset (E : ELEMENT) :
    MULTISET with type elt = E.t =
        struct
            type elt = E.t

            type t =  (elt * int) list

            let empty = []

            let rec add elt = function
                | [] -> [ (elt, 1) ]
                | (e, m) :: rest when elt = e -> (e, succ m) :: rest
                | (e, _) as p :: rest when elt > e -> (elt, 1) :: p :: rest
                | p :: rest -> p :: add elt rest

            let rec multiplicity elt = function
                | [] -> 0
                | (e, _) :: rest when elt > e -> 0
                | (e, m) :: rest when elt = e -> m
                | _ :: rest -> multiplicity elt rest
        end

