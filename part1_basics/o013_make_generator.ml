let make_generator () =
    let uid = ref 0 in
    fun () ->
        uid := !uid + 1 ;
        !uid ;;

let gen = make_generator () ;;
Printf.printf "gen () = %d\n" (gen ()) ;;
Printf.printf "gen () = %d\n" (gen ()) ;;
Printf.printf "gen () = %d\n" (gen ()) ;;
Printf.printf "gen () = %d\n" (gen ()) ;;
