exception Empty

type 'a fifo = {
    front : 'a list ;
    rear : 'a list
}

(* An empty FIFO instance has empty front & rear *)
let empty = { front = [] ; rear = [] }

(*
 * Push an element to the FIFO instance
 * When pushing, copy everything, only the field rear gets a new value
 * Push operation is O(1) in time
*)
let push x fifo = { fifo with rear = x :: fifo.rear }

(*
 * Reverse FIFO if the front is empty
 * The implementation is not scalable
 * The worst case is O(n) in time with n is size of rear
*)
let may_reverse fifo =
    match fifo with
    | { front = [] } ->
        { front = List.rev fifo.rear ; rear = [] }
    | _ -> fifo

(*
 * Pop the front element from a FIFO instance
 * The implementation is not scalable
 * The worst case is O(n) in time with n is size of rear
*)
let pop fifo =
    match may_reverse fifo with
    | { front = [] } -> raise Empty
    | { front = x :: front ; rear } -> x, { front ; rear }

let () =
    let fifo = empty in
    let fifo = push 1 fifo in
    let fifo = push 2 fifo in
    let fifo = push 3 fifo in
    let _, _ = pop fifo in
    let _, _ = pop fifo in
    let x, fifo_3 = pop fifo in
    let y, fifo_4 = pop fifo_3 in
    Printf.printf "x = %d ; y = %d\n" x y

