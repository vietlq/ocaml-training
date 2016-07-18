type 'a stream = 'a stream_cell lazy_t
and 'a stream_cell = Nil | Cons of 'a * 'a stream
val concat : 'a stream -> 'a stream -> 'a stream
val take : int -> 'a stream -> 'a stream
val to_list : 'a stream_cell Lazy.t -> 'a list
val reverse : 'a stream_cell Lazy.t -> 'a stream
val map : ('a -> 'b) -> 'a stream -> 'b stream
val tail : 'a stream_cell Lazy.t -> 'a stream
val map2 : ('a -> 'b -> 'c) -> 'a stream -> 'b stream -> 'c stream
val drop : int -> 'a stream_cell Lazy.t -> 'a stream_cell Lazy.t
