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
    contents : dir_content list    
}
and dir_content =
    | File of file
    | Link of link
    | Directory of directory
(* End of definition *)

let make_file fname lat size = { fname ; lat ; size } ;;
let make_link lname soft target = { lname ; soft ; target } ;;
let make_directory dname contents = { dname ; contents } ;;

let int_gen () = Int64.of_int (Random.int 1234567)
let file1 = make_file "news.txt" (int_gen ()) (int_gen ()) ;;
let file2 = make_file "code.ml" (int_gen ()) (int_gen ()) ;;
let link1 = make_link "secret" true "../keys" ;;
let link2 = make_link "acopy_of_tests.log" false "/tests/01/02/logs" ;;
let contents1 = [ File file1 ; Link link2 ] ;;
let dir1 = make_directory "docs" contents1 ;;
let contents2 = [ File file2 ; Link link1 ; Directory dir1 ] ;;
let dir2 = make_directory "work" contents2 ;;

let print_ls_header () =
    Printf.printf "%4s %19s %19s %s\n" "Type" "Last Accessed Time" "Size" "Name"
;;

let print_file (f : file) () =
    Printf.printf "%4s %19s %19s %s\n" "F"
        (Int64.to_string f.lat)
        (Int64.to_string f.size)
        f.fname
;;

let print_link (l : link) () =
    let name = l.lname ^ " -> " ^ l.target in
    let name = if l.soft then ("*" ^ name) else name in
    Printf.printf "%4s %19s %19s %s\n" "L" "" "" name
;;

let print_direction (d : directory) () =
    Printf.printf "%4s %19s %19d %s\n" "D" "" (List.length d.contents) d.dname
;;

let rec dir_content_printer = function
    | File f -> print_file f ()
    | Link l -> print_link l ()
    | Directory d ->
        print_direction d () ;
        List.iter dir_content_printer d.contents
;;

let ls_cmd dir_content =
    print_ls_header () ;
    dir_content_printer dir_content
;;

let ls_cmd_list ldc =
    print_ls_header () ;
    List.iter dir_content_printer ldc
;;

ls_cmd (Directory dir2) ;;
ls_cmd_list [] ;;

