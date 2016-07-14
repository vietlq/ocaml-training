type 'a nlist = private { len : int; contents : 'a nlist_content; }
and 'a nlist_content = Empty | Node of 'a * 'a nlist_content
val make_nlist : 'a nlist_content -> 'a nlist
val nlist_length : 'a nlist -> int
val nlist_cons : 'a -> 'a nlist -> 'a nlist
val nlist_rev : 'a nlist -> 'a nlist
val nlist_append : 'a nlist -> 'a nlist -> 'a nlist
