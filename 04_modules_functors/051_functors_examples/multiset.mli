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

module Make_multiset (E : ELEMENT) : MULTISET with type elt = E.t

