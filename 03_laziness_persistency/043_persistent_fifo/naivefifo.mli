exception Empty
type 'a fifo = { front : 'a list; rear : 'a list; }
val empty : 'a fifo
val push : 'a -> 'a fifo -> 'a fifo
val may_reverse : 'a fifo -> 'a fifo
val pop : 'a fifo -> 'a * 'a fifo
