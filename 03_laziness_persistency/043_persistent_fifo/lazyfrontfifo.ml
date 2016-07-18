exception Empty

(* A generic FIFO queue *)
type 'a fifo = {
    front      : 'a list ;
    front_len  : int ;
    lazy_front : 'a list lazy_t ;
    rear       : 'a list ;
    rear_len   : int
}

(* The default value of the FIFO queue *)
let empty = {
    front      = [] ;
    front_len  = 0 ;
    lazy_front = lazy [] ;
    rear       = [] ;
    rear_len   = 0
}

(*
 * Check the front, refresh it when needed.
 * This solves edge case where front = []
 * and we still have front_len > rear_len.
 * Consider the case:
     * front = [1] & rear = []
     * lazy_front = [2;3;4]
     * front_len = 4 & rear_len = 0
*)
let check_head fifo =
    match fifo.front with
    | [] -> { fifo with front = Lazy.force fifo.lazy_front }
    | _ -> fifo

(*
 * Check the balance of the front & rear.
 * If front_len <= rear_len, pour all elements from the rear to the front.
 * At the end, run check_head to make sure front is populated.
*)
let check_balance fifo =
    let newfifo =
        if fifo.rear_len < fifo.front_len then
            fifo
        else
            let lazy_front = Lazy.force fifo.lazy_front in
            {   front = lazy_front ;
                front_len = fifo.front_len + fifo.rear_len ;
                lazy_front = lazy (List.rev_append
                    (List.rev lazy_front)
                    (List.rev fifo.rear)) ;
                rear = [] ;
                rear_len = 0 }
    in check_head newfifo

(*
 * Pop an element to the rear of a queue.
 * After the element is added, check the balance of the queue.
 * If the rear is not shorter than the front, join all elements of rear to lazy_front.
 * Note that the field front is only a subset of the field lazy_front.
*)
let push x fifo =
    check_balance
        {   fifo with
            rear = x :: fifo.rear ;
            rear_len = fifo.rear_len + 1 }

(*
 * Pop the first element from the queue.
 * Throw an exception of type Empty if the front is empty.
 * After the element is removed, check the balance of the queue.
 * If the rear is not shorter than the front, join all elements of rear to lazy_front.
 * Note that the field front is only a subset of the field lazy_front.
*)
let pop fifo =
    match fifo with
    | { front = [] } -> raise Empty
    | { front = x :: front ; lazy_front } ->
        x,
        check_balance
            {   fifo with
                front ;
                front_len = fifo.front_len - 1 ;
                lazy_front = lazy (List.tl (Lazy.force lazy_front)) }

(*
 * What's the improvement over the Naivefifo?
 * In Naivefifo, in presence of persistency,
 * if front = [] and rear = [1;2;3],
 * every time you call pop, you spend O(n) on balancing.
 * With Lazyfrontfifo, front is updated in 2 cases:
     * When front = [] and rear is not empty (check_head)
     * When front_len <= rear_len (check_balance)
 * Let's say you have fifo = { front = [] ; rear = [1;2;3] }:
     * The first time you run pop fifo, it will be O(n)
     * The next time you run pop fifo, it will be O(1)
     * Note that pushing and popping fifo/its resulting records will be O(1) for the next n more operations
     * Note that both pushing and popping are amortized O(1)
     * Pop & push both can lead to check_balance, and then check_head
*)

