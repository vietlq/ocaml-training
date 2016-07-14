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

let op intopt floatopt number1 number2 =
    let float_or_int f =
        let i = int_of_float f in
        if float_of_int i = f then Int i else Float f
    in
    match number1, number2 with
    | Int n1, Int n2 -> Int (intopt n1 n2)
    | Int n1, Float n2 -> float_or_int (floatopt (float_of_int n1) n2)
    | Float n1, Int n2 -> float_or_int (floatopt n1 (float_of_int n2))
    | Float n1, Float n2 -> float_or_int (floatopt n1 n2)

let ( + ) = op ( + ) ( +. )
let ( - ) = op ( - ) ( -. )
let ( * ) = op ( * ) ( *. )
let ( / ) = op ( / ) ( /. )
