let matches value mat =
    let res = ref 0 in
    let rec loop_rows i =
        if i < Array.length mat then
            let rec loop_cols j =
                if j < Array.length mat.(i) then begin
                    if mat.(i).(j) = value then
                        res := !res + 1 ;
                        loop_cols (j + 1)
                end in
            loop_cols 0 ;
            loop_rows (i + 1) in
    loop_rows 0;
    !res ;;

let mat = Array.make_matrix 5 5 0 ;;
let rec loop i =
        if i = 5 then ()
            else
                        let () = mat.(i).(i) <- 1 in
                                loop (i + 1)
in loop 0 ;;

Printf.printf "matches 1 mat = %d\n%!"
    (matches 1 mat) ;;
Printf.printf "matches 0 mat = %d\n%!"
    (matches 0 mat) ;;

