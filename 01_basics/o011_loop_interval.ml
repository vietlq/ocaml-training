let rec call_on_interval min max f =
    if min <= max then begin
        f min ;
        call_on_interval (min + 1) max f
    end ;;

call_on_interval (-8) (-2) (Printf.printf "%d\n") ;;

let rec map_interval min max f =
    if min > max then
        []
    else
        f min :: map_interval (min + 1) max f ;;

let res = map_interval 10 20 succ ;;
List.iter (Printf.printf "%d\n") res ;;
