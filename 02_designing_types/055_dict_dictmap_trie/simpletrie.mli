type ('a, 'b) trie = Node of 'b option * ('a * ('a, 'b) trie) list
val empty : ('a, 'b) trie
val set : 'a list -> 'b -> ('a, 'b) trie -> ('a, 'b) trie
val get : 'a list -> ('a, 'b) trie -> 'b
val present : 'a list -> ('a, 'b) trie -> bool
