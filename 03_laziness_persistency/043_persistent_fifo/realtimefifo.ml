exception Empty

type 'a stream = 'a stream_cell lazy_t
and 'a stream_cell = Nil | Cons of 'a * 'a stream

type 'a fifo = {
    front : 'a stream ;
    rear  : 'a list ;
    accu  : 'a stream
}

(* accu is a sub-stream of the front *)
let empty = {
    front = lazy Nil ;
    rear  = [] ;
    accu  = lazy Nil
}

(*
 * Note that this function is called with an invariant:
     * Rear has exactly 1 more element compared to Front
 * The rear is being rotated and all rear elements being pushed to accu
 * The elements of front is being pushed to the front of stream
 * The effect of this function is:
     * Lazy.force front @ List.rev rear @ Lazy.force accu
 * The function check_balance guarantees the precondition required by rotate_rear.
*)
let rec rotate_rear fifo =
    match fifo with
    | { front = lazy Nil ; rear = [x] ; accu } ->
        lazy (Cons (x, accu))
    | { front = lazy (Cons (x, xs)) ; rear = y :: ys ; accu } ->
        lazy (Cons (x, rotate_rear {
            front = xs ; rear = ys ; accu = lazy (Cons (y, accu))
        }))
    | _ -> assert false

(*
 * Check balance of the FIFO.
 * For every push/pop action, remove the front element from accu.
 * If the accu is empty, rotate the rear, join with front.
 * The new front = accu = (old_front @ old_rear) & rear = [].
*)
let check_balance fifo =
    match Lazy.force fifo.accu with
    | Cons (_, accu) -> { fifo with accu }
    | Nil ->
        let front = rotate_rear fifo in
        { front ; rear = [] ; accu = front }

(*
 * Push an item to FIFO.
 * Afer pushing we will check balance and reorganize if needed.
*)
let push x fifo = check_balance { fifo with rear = x :: fifo.rear }

(*
 * Pop the front item from FIFO.
 * Afer popping we will check balance and reorganize if needed.
*)
let pop fifo =
    match Lazy.force fifo.front with
    | Nil -> raise Empty
    | Cons (x, front) -> x, check_balance { fifo with front }

