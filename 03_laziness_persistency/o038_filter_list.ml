(*
 * List
 * Write a function filter p l of type ('a -> bool) -> 'a list -> 'a list
 * that returns all the elements of the list l that satisfy the predicate p.
 * The order of the elements in the input should be preserved.
*)

(* Declarative and non-tail recursive *)
let rec filter f xs =
    match xs with
    | [] -> []
    | x :: xs ->
        if f x then x :: filter f xs else filter f xs

(* Using List.fold_right, non-tail recursive *)
let filter f xs =
    List.fold_right
        (fun x acc -> if f x then x :: acc else acc)
        xs []

(* Using List.fold_right, not-tail recursive. Also using an accumulator *)
let filter f xs =
    let may_cons x acc = if x then x :: acc else acc in
    List.fold_right may_cons xs []

(* Using an accumulator & tail-recursive *)
let filter f xs =
    let rec loop acc xs =
        match xs with
        | [] -> List.rev acc
        | x :: xs -> loop (if f x then x :: acc else acc) xs
    in
    loop [] xs

(* Using List.fold_left, tail-recursive *)
let filter f xs =
    List.rev @@
    List.fold_left
        (fun acc x -> if f x then x :: acc else acc)
        [] xs

