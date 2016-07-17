(*
 * exn is an extensible sum type
 * The keyword exception adds a constructor to exn
 * Constructors can take arguments, as with sum types
*)

exception Position of int

(*
 * Find the first index in the array that equals a value.
 * The result is passed as an exception.
 * Not a good way, but just an example.
*)
let find_in_array arr v =
    try
        for i = 0 to Array.length arr - 1 do
            if arr.(i) = v then raise (Position i)
        done ;
        None
    with Position p -> Some p
;;

(*
 * try and raise have O(1) cost
*)

exception Zero

(* Quickly breaks the loop, but not necessary *)
let mult_ints l =
    try
        let rec loop = function
            | [] -> 1
            | 0 :: _ -> raise Zero
            | v :: vs -> v * loop vs
        in loop l
    with Zero -> 0
;;

