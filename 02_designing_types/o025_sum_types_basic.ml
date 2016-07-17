(* Sum types can be used as enums/stand-alone tags *)
(* type name = Constructor | ... | Constructor *)
type axis = Vertical | Horizontal
type point = { mutable x : float ; mutable y : float }

let mirror point axis =
    match axis with
    | Vertical -> point.x <- -. point.x
    | Horizontal -> point.y <- -. point.y
;;

(* Sum types can be used as stand-alone tags or attached to values *)
(* type name = Constructor of type | Constructor | ... *)
type operation =
    | Mirror of axis
    | Scale of float
    | Identity

let apply point operation =
    match operation with
    | Mirror Vertical -> point.x <- -. point.x
    | Mirror Horizontal -> point.y <- -. point.y
    | Scale scale ->
        point.x <- scale *. point.x ;
        point.y <- scale *. point.y
    | Identity -> ()
;;

let make_point x y = { x ; y } ;;

let print_point { x ; y } =
    Printf.printf "Point { x : %g ; y : %g }\n" x y ;;

let point1 = make_point 3. (-4.) ;;
print_point point1 ;;
mirror point1 Vertical ;;
print_point point1 ;;
mirror point1 Horizontal ;;
print_point point1 ;;

apply point1 (Scale 2.5) ;;
print_point point1 ;;
apply point1 (Mirror Vertical) ;;
print_point point1 ;;
apply point1 (Mirror Horizontal) ;;
print_point point1 ;;
apply point1 Identity ;;
print_point point1 ;;

