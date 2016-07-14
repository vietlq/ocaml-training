type 'a nlist = private Nnil | Ncons of int * 'a * 'a nlist
val nlist_length : 'a nlist -> int
val nlist_cons : 'a -> 'a nlist -> 'a nlist
val nlist_rev : 'a nlist -> 'a nlist
val nlist_append : 'a nlist -> 'a nlist -> 'a nlist
