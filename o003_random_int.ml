let () = Random.self_init () ;;
let roll = Random.int 100 ;;
print_endline
    ("Here is your percentage dice roll: "
        ^ string_of_int (roll + 1)
        ^ "%") ;;
Printf.printf
    "Or as two D10: %d and %d\n"
    (roll mod 10 + 1)
    (roll / 10 + 1) ;;

