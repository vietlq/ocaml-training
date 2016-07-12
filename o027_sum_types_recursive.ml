(*
 * Type bindings are always recursive, unlike let bindings
 * type t1 = ... and t2 = ... make t1 & t2 recursive
 * Use recursive functions to treat recursive types
 * Always remember to specify & handle base case for recursion
*)

type node = {
    mutable value : float ;
    mutable left : node option ;
    mutable right : node option
}

let rec infix f = function
    | None -> ()
    | Some n ->
        infix f n.left ;
        f n.value ;
        infix f n.right
;;

let make_node value left right = { value ; left ; right } ;;

let node1 = make_node 1. None None ;;
let node2 = make_node 2. (Some node1) None ;;
let node3 = make_node 3. None (Some node2) ;;
let node4 = make_node 4. None None ;;
let node5 = make_node 5. (Some node3) (Some node4) ;;

infix (Printf.printf "%g; ") (Some node5) ;;
print_endline "" ;;

