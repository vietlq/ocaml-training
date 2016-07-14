type number = Int of int | Float of float

let number_is_zero = function
    | Int n -> n = 0
    | Float f -> f = 0.

let int_of_number = function
    | Int n -> n
    | Float f -> int_of_float f

let float_of_number = function
    | Int n -> float_of_int n
    | Float f -> f

let print_number = function
    | Int n -> Printf.printf "Int %d" n
    | Float f -> Printf.printf "Float %g" f

(* Manually define for each operator + - * / *)
let (+) number1 number2 =
    match number1, number2 with
    | Int n1, Float n2 -> Float ((float_of_int n1) +. n2)
    | Float n1, Int n2 -> Float (n1 +. (float_of_int n2))
    | Int n1, Int n2 -> Int (n1 + n2)
    | Float n1, Float n2 -> Float (n1 +. n2)
;;

let (-) number1 number2 =
    match number1, number2 with
    | Int n1, Float n2 -> Float ((float_of_int n1) -. n2)
    | Float n1, Int n2 -> Float (n1 -. (float_of_int n2))
    | Int n1, Int n2 -> Int (n1 - n2)
    | Float n1, Float n2 -> Float (n1 -. n2)
;;

(* Test new + *)
print_number (Int 1) ;;
print_string " + " ;;
print_number (Float 0.333) ;;
print_string " = " ;;
print_number (Int 1 + Float 0.333) ;;
print_endline "" ;;

(* Test new - *)
print_number (Int 1) ;;
print_string " - " ;;
print_number (Float 0.333) ;;
print_string " = " ;;
print_number (Int 1 - Float 0.333) ;;
print_endline "" ;;

(* Use generic type and generic function *)
type 'a operator = {
    intopt : int -> int -> int ;
    floatopt : float -> float -> float ;
}

let operation (op : 'a operator) number1 number2 =
    match number1, number2 with
    | Int n1, Float n2 -> Float (op.floatopt (float_of_int n1) n2)
    | Float n1, Int n2 -> Float (op.floatopt n1 (float_of_int n2))
    | Int n1, Int n2 -> Int (op.intopt n1 n2)
    | Float n1, Float n2 -> Float (op.floatopt n1 n2)


