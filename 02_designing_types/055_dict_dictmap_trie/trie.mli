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
    TRIE_S with type key = P.key and type value = P.value

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
    TRIE_STRING_S with type value = V.value

