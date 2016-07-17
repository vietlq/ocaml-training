(*
 * Types can have parameters
 * For applying a same structure to different base types
 * For building polymorphic containers
 * For factorizing code
*)

(*
 * Syntax
 * Single parameter
 * type 'a t = ...
 * Several parameter
 * type ('a, 'b) t = ..
*)

(*
 * Restrictions
 * Variables appearing on the right must be declared as parameters
 * Parameters should appear on the right
*)

(*
 * Define a minimal expression language
 * (add 1 2 3 4 5)
 * (letin x (input) (add 1 input))
*)
type ast =
    | Const of string                   (* const *)
    | Operation of string * ast list    (* (op _ _ ...) *)
    | Var of string                     (* var *)
    | Letin of string * ast * ast       (* (let var _ _) *)

(*
 * Define an intermediate language for evaluation to a type 'a
 * This is a single parameter polymorphic type
*)
type 'a expr =
    | Const of 'a
    | Operation of ('a list -> 'a) * 'a expr list
    | Var of string
    | Letin of string * 'a expr * 'a expr

(* Define an evaluator *)
let eval expr =
    let rec eval env = function
        | Const x -> x
        | Operation (f, args) ->
            f (List.map (eval env) args)
        | Var v -> List.assoc v env
        | Letin (n, v, b) ->
            let env = (n, eval env v) :: env in
            eval env b in
    eval [] expr
;;

(*
 * We want to parse expression over different domains
 * For this we write a generic parsing algorithm
 * We abstract the specificities in a record
*)
type 'a parsers = {
    parse_const : string -> 'a ;
    parse_operation : string -> ('a list -> 'a)
}

(* Define parser *)
let rec parse : 'a parsers -> ast -> 'a expr =
    fun parsers -> function
        | Const s ->
            Const (parsers.parse_const s)
        | Operation (n, args) ->
            Operation (parsers.parse_operation n, List.map (parse parsers) args)
        | Var n ->
            Var n
        | Letin (n, v, b) ->
            Letin (n, parse parsers v, parse parsers b)
;;

(* Define int instance *)
let int_parsers : int parsers = {
    parse_const = int_of_string ;
    parse_operation = (function
        | "add" ->
            (function
                | [] -> invalid_arg "add"
                | x :: xs -> List.fold_left (+) x xs)
        | "sub" ->
            (function
                | [x] -> -x
                | [x ; y] -> x - y
                | _ -> invalid_arg "sub")
        | _ -> raise Not_found
    )
} ;;

