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
    val iter : ('a list -> key list -> t -> 'a list) -> t -> 'a list
    val keys : t -> key list list
    val items : t -> (key list * value) list
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
    val iter : ('a list -> char list -> t -> 'a list) -> t -> 'a list
    val keys : t -> key list
    val items : t -> (key * value) list
end

module type VALUE = sig
    type value
end

module Make_TrieString (V : VALUE) :
    TRIE_STRING_S with type value = V.value

