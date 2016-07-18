exception Empty
type 'a fifo
val empty : 'a fifo
val push : 'a -> 'a fifo -> 'a fifo
val pop : 'a fifo -> 'a * 'a fifo
