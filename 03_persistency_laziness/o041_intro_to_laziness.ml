let fact x =
    let rec aux acc x =
        if x < 2 then acc
        else aux (x * acc) (x - 1)
    in aux 1 x

(*
 * The first call to Lazy.force x will compute the factorial
 * and memoize the result. The second call will return
 * immediately the previously computed result.
*)
let display : int lazy_t -> unit =
    fun x ->
        if Random.bool () then
            Printf.printf "x + x = %d\n" (Lazy.force x + Lazy.force x)
;;

let () = display (lazy (fact 15)) ;;
