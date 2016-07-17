(*
 * Unlike tuples, record types are distinct,
 * even they have the same field types
*)
type point = { mutable x : float ; mutable y : float }
type vector = { mutable u : float ; mutable v : float }
type aggregate =
    | Point of point
    | Vector of vector

(*
 * The compiler can deduce the type based on field names
 * No annotation required here
*)
let translate ({ x ; y } as p) { u ; v } =
    p.x <- x +. u ;
    p.y <- y +. v ;;

let add_vector src_vec tmp_vec =
    src_vec.u <- src_vec.u +. tmp_vec.u ;
    src_vec.v <- src_vec.v +. tmp_vec.v ;;

(* We can omit x = x & y = y in this case *)
let make_point x y = { x ; y } ;;
let make_vector x y = { u = x ; v = y } ;;

let printer = function
    | Point p -> Printf.printf "Point { x : %g ; y : %g }\n" p.x p.y
    | Vector v -> Printf.printf "Vector { u : %g ; v : %g }\n" v.u v.v

let point1 = make_point 2. 3. ;;
let vector1 = make_vector 10. (-5.) ;;
let vector2 = make_vector (-8.) 3. ;;

printer (Point point1) ;;
printer (Vector vector1) ;;

translate point1 vector1 ;;
printer (Point point1) ;;

print_endline "----" ;;
printer (Vector vector1) ;;
add_vector vector1 vector2;;
printer (Vector vector2) ;;
printer (Vector vector1) ;;

