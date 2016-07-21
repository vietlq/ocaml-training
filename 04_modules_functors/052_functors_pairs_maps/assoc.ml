module type COMPONENT = sig
    type t
end

module type PAIR = sig
    type t
    type left_elt
    type right_elt
    val make : left_elt -> right_elt -> t
    val left : t -> left_elt
    val right : t -> right_elt
end

module SimplePair (L : COMPONENT) (R : COMPONENT) :
    PAIR with type left_elt = L.t and type right_elt = R.t = struct
    type t = { left : L.t ; right : R.t }
    type left_elt = L.t
    type right_elt = R.t
    let make left right = { left ; right }
    let left { left } = left
    let right { right } = right
end

module Pair (L : COMPONENT) (R : COMPONENT) :
    PAIR with type left_elt = L.t and type right_elt = R.t = struct
    type t = { left : L.t ; right : R.t }
    type left_elt = L.t
    type right_elt = R.t
    let make left right = { left ; right }
    let left { left } = left
    let right { right } = right
end

