let print_string_list ls =
    List.iter print_endline ls ;;

let print_string_list2 ls =
    for i = 0 to (List.length ls) do
        print_endline (List.nth ls i)
    done ;;

let print_string_list3 ls =
    let count = ref 0 in
    while !count < (List.length ls) do
        print_endline (List.nth ls !count) ;
        count := !count + 1
    done ;;

let print_string_list3 ls =
    let tl = ref ls in
    while !tl <> [] do
        print_endline (List.hd !tl) ;
        tl := List.tl !tl
    done ;;

