module type COMPONENT = sig type t end

module SimplePair :
    functor (L : COMPONENT) (R : COMPONENT) ->
        sig
            type t
            type left_elt = L.t
            type right_elt = R.t
            val make : left_elt -> right_elt -> t
            val left : t -> left_elt
            val right : t -> right_elt
        end

module type PAIR_S = sig
  type t
  type left_elt
  type right_elt
  val make : left_elt -> right_elt -> t
  val left : t -> left_elt
  val right : t -> right_elt
end

module Pair (L : COMPONENT) (R : COMPONENT) :
    PAIR_S with type left_elt = L.t and type right_elt = R.t

module type ASSOC_S = sig
    type t
    type key
    type value
    val empty : t
    val set : key -> value -> t -> t
    val get : key -> t -> value
    val unset : key -> t ->t
end

module Assoc (P : PAIR_S) :
    ASSOC_S with type key = P.left_elt and type value = P.right_elt

