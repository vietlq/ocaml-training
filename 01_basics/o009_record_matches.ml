let record amatch mat =
    let rec loop_rows i acc =
        if i < Array.length mat then
            let rec loop_cols j acc =
                if j < Array.length mat.(i) then
                    if mat.(i).(j) = amatch then
                        loop_cols (j+1) ((i, j) :: acc)
                    else
                        loop_cols (j+1) acc
                else acc
            in loop_rows (i+1) (loop_cols 0 acc)
        else acc
    in loop_rows 0 [] ;;

let mat = Array.make_matrix 5 5 0 ;;
let rec loop i =
        if i = 5 then ()
            else
                        let () = mat.(i).(i) <- 1 in
                                loop (i + 1)
in loop 0 ;;

let print_matches amatch matches =
    let printer (i, j) =
        Printf.printf "(%d, %d); " i j
    in
    Printf.printf "Print matches of %d:\n" amatch ;
    List.iter printer matches ;
    print_endline "" ;;

let matches0 = record 0 mat ;;
let matches1 = record 1 mat ;;

print_matches 0 matches0 ;;
print_matches 1 matches1 ;;
