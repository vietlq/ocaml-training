let operator (name : string) : int -> int -> int =
    match name with
    | "min" -> min
    | "max" -> max
    | "+" -> (+)
    | "-" -> (-)
    | "*" -> ( * )
    | "/" -> (/)
    | _ -> failwith "Unknown operator name" ;;

let plus = operator "+" ;;
Printf.printf "2 + 3 = %d\n" (plus 2 3) ;;

let print_hook = ref print_int ;;
let print num = !print_hook num ;;

let set_delim_print start stop =
    let printer num =
        print_string (start ^ string_of_int num ^ stop) in
    print_hook := printer ;;

set_delim_print "<<" ">>\n" ;;
print 3 ;;
let arr = [1; 2; 3; 4; 5] ;;
List.iter print arr ;;

