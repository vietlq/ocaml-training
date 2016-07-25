type ('a, 'b) trie
val empty : ('a, 'b) trie
val set : 'a list -> 'b -> ('a, 'b) trie -> ('a, 'b) trie
val get : 'a list -> ('a, 'b) trie -> 'b
val present : 'a list -> ('a, 'b) trie -> bool
val iter :
  ('a list -> 'b list -> ('c, 'd) trie -> 'a list) ->
  ('b, 'd) trie -> 'a list
val keys : ('a, 'b) trie -> 'a list list
val items : ('a, 'b) trie -> ('a list * 'b) list
