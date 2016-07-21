module type COMPONENT = sig
    type t
end

module SimplePair (L : COMPONENT) (R : COMPONENT) = struct
    type t = { left : L.t ; right : R.t }
    type left_elt = L.t
    type right_elt = R.t
    let make left right = { left ; right }
    let left { left } = left
    let right { right } = right
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
    PAIR_S with type left_elt = L.t and type right_elt = R.t = struct
    type t = { left : L.t ; right : R.t }
    type left_elt = L.t
    type right_elt = R.t
    let make left right = { left ; right }
    let left { left } = left
    let right { right } = right
end

module type ASSOC_S = sig
    type t
    type key
    type value
    val empty : t
    val set : key -> value -> t -> t
    val get : key -> t -> value
    val unset : key -> t -> t
end

module Assoc (P : PAIR_S) :
    ASSOC_S with type key = P.left_elt and type value = P.right_elt = struct
	type t = Empty | Value of P.t * t

	type key = P.left_elt

	type value = P.right_elt

	let empty = Empty

	let rec set k v = function
		| Empty -> Value (P.make k v, Empty)
		| Value (pair, next) ->
			if P.left pair = k then Value (P.make k v, next)
			else Value (pair, set k v next)

	let rec get k = function
		| Empty -> raise Not_found
		| Value (pair, next) ->
			if P.left pair = k then P.right pair
			else get k next

	let rec unset k = function
		| Empty -> Empty
		| Value (pair, next) ->
			if P.left pair = k then next
			else Value (pair, unset k next)
end

