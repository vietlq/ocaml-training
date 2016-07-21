module type COMPONENT = sig type t end

module Pair :
  functor (L : COMPONENT) (R : COMPONENT) ->
    sig
      type t
      type left_elt
      type right_elt
      val make : left_elt -> right_elt -> t
      val left : t -> left_elt
      val right : t -> right_elt
    end

