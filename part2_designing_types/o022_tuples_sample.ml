
(* These 2 types are the same. Annotation for humans only *)
type vector = float * float
type point = float * float

let translate ((x, y) : point) ((u, v) : vector) : point =
    (x +. u, y +. v) ;;

let point1 = (2. , 3.) ;;
let vector1 = (10. , -5.) ;;

let point2 = translate point1 vector1 ;;
let point3 = translate vector1 point1 ;;

let print_point ((x, y) : point) =
    Printf.printf "(%g , %g)\n" x y
;;

print_string "print_point point1 = " ;;
print_point point1 ;;
print_string "print_point vector1 = " ;;
print_point vector1 ;;
print_string "print_point point2 = " ;;
print_point point2 ;;
print_string "print_point point3 = " ;;
print_point point3 ;;

Printf.printf "point2 = point3 => %b\n" (point2 = point3) ;;
Printf.printf "point2 == point3 => %b\n" (point2 == point3) ;;

