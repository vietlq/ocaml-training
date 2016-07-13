(*
 * Type bindings are always recursive, unlike let bindings
 * type t1 = ... and t2 = ... make t1 & t2 recursive
 * Use recursive functions to treat recursive types
 * Always remember to specify & handle base case for recursion
*)

(* Binary tree example *)
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

(* Example with sum of types *)
type roadmap =
    | Stop
    | Take of string * roadmap
    | Drive of int * roadmap

let print_roadmap roadmap =
    let rec loop count mile = function
        | Stop ->
            Printf.printf "%d. At mile %d stop.\n" count mile
        | Take (dir, rest) ->
            Printf.printf "%d. At mile %d take exit %s.\n" count mile dir ;
            loop (count + 1) mile rest
        | Drive (n, rest) ->
            Printf.printf "%d. Drive for %d miles\n" count n ;
            loop (count + 1) (mile + n) rest
    in loop 1 0 roadmap
;;

let roadmap1 = Drive (12, Take ("Route 66", Drive (30, Stop))) ;;
print_roadmap roadmap1 ;;

(* More recursive types *)
type road = {
    name : string ;
    exits : (int * exit) list
}
and exit =
    | Exit of road | Toll of float * road | Service
;;

(* File system *)
type file = {
    fname : string ;
    lat : int64 ;
    size : int64 ;
}
and link = {
    lname : string ;
    soft : bool ;
    target : string ;
}
and directory = {
    dname : string ;
    contains : dir_content list    
}
and dir_content =
    | File of file
    | Link of link
    | Directory of directory
(* End of definition *)


