module type ELEMENT = sig type t val compare : t -> t -> int end

module type MULTISET =
  sig
    type t
    type elt
    val empty : t
    val add : elt -> t -> t
    val multiplicity : elt -> t -> int
  end

module Make_multiset :
  functor (E : ELEMENT) -> MULTISET with type elt = E.t

module type MULTISET_FTR =
  functor (E : ELEMENT) -> MULTISET with type elt = E.t

module MakeMultiSet : MULTISET_FTR

