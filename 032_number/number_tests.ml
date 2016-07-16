open Number ;;

print_number (number_of_int 3) ; print_endline "" ;;
print_number (number_of_float (-0.333)) ; print_endline "" ;;

let number1 = number_of_int 1 ;;
let number2 = number_of_float (-0.444) ;;

Printf.printf "%s + %s = %s\n"
    (sprint_number number1)
    (sprint_number number2)
    (sprint_number (number1 + number2)) ;;

Printf.printf "%s - %s = %s\n"
    (sprint_number number1)
    (sprint_number number2)
    (sprint_number (number1 - number2)) ;;

Printf.printf "%s * %s = %s\n"
    (sprint_number number1)
    (sprint_number number2)
    (sprint_number (number1 * number2)) ;;

Printf.printf "%s / %s = %s\n"
    (sprint_number number1)
    (sprint_number number2)
    (sprint_number (number1 / number2)) ;;

