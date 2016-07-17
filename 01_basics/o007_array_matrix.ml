let empty = [||] ;;
let sample = [| 1; 2; 3; 4 |] ;;
let chars = [| 'a'; 'p'; 't'; 'z' |] ;;
let mat = Array.make_matrix 5 5 0 ;;

let first = sample.(0) ;;
sample.(0) <- 1001 ;;
let rec loop i =
    if i = 5 then ()
    else
        let () = mat.(i).(i) <- 1 in
        loop (i + 1)
in loop 0 ;;

Printf.printf
    "first = %d; sample(0) = %d\n%!"
    first sample.(0) ;;
Printf.printf
    "mat.(3).(3) = %d; mat.(2).(1) = %d\n%!"
    mat.(3).(3) mat.(2).(1) ;;

