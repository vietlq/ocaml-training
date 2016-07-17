(* A generic stream is a lazy type *)
type 'a stream = 'a stream_cell lazy_t
and 'a stream_cell = Nil | Cons of 'a * 'a stream

(*
 * Concatenate 2 streams
 * The idiom lazy begin ... end is the same as lazy ( ... )
 * If you expect a lazy result, always wrap it inside lazy
*)
let rec concat : 'a stream -> 'a stream -> 'a stream =
    fun xs ys ->
        lazy begin
            match Lazy.force xs with
            | Nil -> Lazy.force ys
            | Cons (x, xs) -> Cons (x, concat xs ys)
        end

(*
 * Take n items from a stream
 * The idiom lazy begin ... end is the same as lazy ( ... )
 * If you expect a lazy result, always wrap it inside lazy
*)
let rec take : int -> 'a stream -> 'a stream =
    fun n xs ->
        lazy begin
            if n <= 0 then
                Nil
            else
                match Lazy.force xs with
                | Nil -> Nil
                | Cons (x, xs) -> Cons (x, take (n - 1) xs)
        end

(*
 * Convert a stream to list
 * Note that this function extracts all elements and the list is not lazy,
 * thus we don't use lazy begin ... end or lazy ( ... ).
*)
let rec to_list xs =
    match Lazy.force xs with
    | Nil -> []
    | Cons (x, xs) -> x :: to_list xs

(*
 * Reverse a stream
 * Since we extract all elements from a stream,
 * we need to compensate for its laziness in the new stream.
 * For each result returned, we need to wrap it in lazy.
 * An accumulator used to contain lazy result. Pay attention to lazy Nil
*)
let reverse xs =
    let rec rev acc xs =
        match Lazy.force xs with
        | Nil -> acc
        | Cons (x, xs) -> rev (lazy (Cons (x, acc))) xs
    in rev (lazy Nil) xs

(*
 * Map a stream to another stream
 * We meet again, lazy begin ... end
 * Example:
     * let rec naturals = lazy (Cons (1, map succ naturals))
*)
let rec map : ('a -> 'b) -> 'a stream -> 'b stream =
    fun f xs ->
        lazy begin
            match Lazy.force xs with
            | Nil -> Nil
            | Cons (x, xs) -> Cons (f x, map f xs)
        end

(*
 * Tail of a stream
*)
let tail xs =
    match Lazy.force xs with
    | Nil -> invalid_arg "empty"
    | Cons (_, xs) -> xs

(*
 * Map 2 streams into a third one
 * Note here we don't use Lazy.force, instead we use lazy for matching.
 * As we are not certain about the end of each stream, this provides safety.
 * Example:
     * let rec fibs = lazy (Cons (1, lazy (Cons (1, map2 (+) fibs (tail fibs)))))
*)
let rec map2 f xs ys =
    lazy begin
        match xs, ys with
        | lazy Nil, _ | _, lazy Nil -> Nil
        | lazy (Cons (x, xs)), lazy (Cons (y, ys)) ->
            Cons (f x y, map2 f xs ys)
    end

(*
 * Drop first n elements - generic version of tail
*)
let rec drop n xs =
    if n < 1 then xs
    else
        match Lazy.force xs with
        | Nil -> invalid_arg "drop empty"
        | Cons (x, xs) -> drop (n - 1) xs

(*
 * Play with some functions:
     * to_list (take 10 naturals)
     * to_list (take 10 squares)
     * to_list (take 10 odd_nums)
     * to_list (take 10 fibs)
     * to_list (take 10 (drop 10 fibs))
*)

(* The infinite stream of all natural numbers *)
let rec naturals = lazy (Cons (1, map succ naturals))

(* The infinite stream of square numbers *)
let squares = map (fun x -> x * x) naturals

(* The infinite stream of odd numbers *)
let odd_nums = map (fun x -> 2 * x - 1) naturals

(* The infinite stream of Fibobacci numbers *)
let rec fibs =
    lazy (Cons (1, lazy (Cons (1, map2 (+) fibs (tail fibs)))))

