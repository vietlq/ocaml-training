(** An efficient implementation of FIFO that provides real-time guarantee. This implementation uses streams. *)

(** Exception type raised when the FIFO is empty. *)
exception Empty

(** Abstract generic type for the FIFO. *)
type 'a fifo

(** An empty FIFO. One use use this as a starting point & push elements. *)
val empty : 'a fifo

(** Push an element to the FIFO. Amortized O(1) time complexity. *)
val push : 'a -> 'a fifo -> 'a fifo

(** Pop the first element from the FIFO. Amortized O(1) time complexity. *)
val pop : 'a fifo -> 'a * 'a fifo

