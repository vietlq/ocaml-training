module type COMPONENT = sig
    type t
end

module Pair (L : COMPONENT) (R : COMPONENT) = struct
    type t = { left : L.t ; right : R.t }
    type left_elt = L.t
    type right_elt = R.t
    let make left right = { left ; right }
    let left { left } = left
    let right { right } = right
end

