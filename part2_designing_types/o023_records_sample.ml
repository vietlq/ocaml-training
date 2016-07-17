(*
 * Unlike tuples, record types are distinct,
 * even they have the same field types
*)
type point = { x : float ; y : float }
type vector = { u : float ; v : float }
type aggregate =
    | Point of point
    | Vector of vector

(*
 * Annotations needed when 2 record types have similar field names
 * The annotations here only for example
*)
let translate (p : point) (v : vector) : point =
    { x = p.x +. v.u ; y = p.y +. v.v } ;;

(* We can omit x = x & y = y in this case *)
let make_point x y = { x ; y } ;;
let make_vector x y = { u = x ; v = y } ;;

let printer = function
    | Point p -> Printf.printf "Point { x : %g ; y : %g }\n" p.x p.y
    | Vector v -> Printf.printf "Vector { u : %g ; v : %g }\n" v.u v.v

let point1 = make_point 2. 3. ;;
let vector1 = make_vector 10. (-5.) ;;
let point2 = translate point1 vector1 ;;

printer (Point point1) ;;
printer (Vector vector1) ;;
printer (Point point2) ;;

