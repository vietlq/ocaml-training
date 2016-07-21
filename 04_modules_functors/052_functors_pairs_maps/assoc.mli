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

module type PAIR = sig
  type t
  type left_elt
  type right_elt
  val make : left_elt -> right_elt -> t
  val left : t -> left_elt
  val right : t -> right_elt
end

module Pair (L : COMPONENT) (R : COMPONENT) :
    PAIR with type left_elt = L.t and type right_elt = R.t

