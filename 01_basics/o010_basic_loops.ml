for i = 0 to 10 do
    Printf.printf "I got %d bottle(s) of wine\n" i
done ;;

for j = 10 downto 0 do
    Printf.printf "There are %d cake(s) left in the fridge\n" j
done ;;

print_endline "Welcome to dice simulator" ;;
let continue = ref true ;;
while !continue do
    print_int (Random.int 6 + 1) ;
    print_endline "\nContinue (y/n)?" ;
    continue := (read_line () = "y")
done ;;
