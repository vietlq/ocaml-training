module type PAIR = sig
    type key
    type value
end

module type TRIE_S = sig
    type t
    type key
    type value
    val empty : t
    val set : key list -> value -> t -> t
    val get : key list -> t -> value
    val present : key list -> t -> bool
end

module Make (P : PAIR) :
    TRIE_S with type key = P.key and type value = P.value = struct

	type key = P.key
	type value = P.value
	type t = Node of value option * (key * t) list

    let empty = Node (None, [])

	let rec set key v d =
		let rec descend = function
			| [], Node (_, subs) -> Node (Some v, subs)
			| [x], Node (ended, []) -> Node (ended, [(x, Node (Some v, []))])
			| x :: y :: xs, Node (ended, []) -> Node (ended, [(x, descend (y :: xs, empty))])
			| x :: xs, Node (ended, (c, d) :: rest) -> (
				if x = c then
					Node (ended, (c, descend (xs, d)) :: rest)
				else
                    let Node (_, newrest) = descend (x :: xs, Node (ended, rest)) in
					Node (ended, (c, d) :: newrest)
			)
		in
		match key with
		| [] -> invalid_arg "set empty key"
		| key -> descend (key, d)

	let rec get key d =
		let rec descend = function
			| [], Node (ended, _) -> ended
			| _ :: _, Node (_, []) -> None
			| x :: xs as chars , Node (ended, (c, d) :: rest) ->
				if x = c then descend (xs, d)
				else descend (chars, Node (ended, rest))
		in
		match descend (key, d) with
		| None -> raise Not_found
		| Some v -> v

	let rec present key d =
		match get key d with
		| exception Not_found -> false
		| v -> true
end

module type TRIE_STRING_S = sig
    type t
    type key = string
    type value
    val empty : t
    val set : key -> value -> t -> t
    val get : key -> t -> value
    val present : key -> t -> bool
end

module type VALUE = sig
    type value
end

module Make_TrieString (V : VALUE) :
    TRIE_STRING_S with type value = V.value = struct

	type key = string
	type value = V.value

	module TrieString = Make (struct type key = char type value = V.value end)

	type t = TrieString.t

	let empty = TrieString.empty

	let explode s =
		let rec aux acc n =
			if n < 0 then acc else aux (s.[n] :: acc) (n - 1) in
		aux [] (String.length s - 1)

	let set key value d = TrieString.set (explode key) value d

	let get key d = TrieString.get (explode key) d

	let present key d = TrieString.present (explode key) d
end

