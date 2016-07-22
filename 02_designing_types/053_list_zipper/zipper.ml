type 'a list_zipper = {
    left  : 'a list ;
    right : 'a list
}

let of_list l = { left = [] ; right = l }

let move_right { left ; right } =
    match right with
    | [] -> invalid_arg "move_right"
    | x :: right -> { left = x :: left ; right }

let move_left { left ; right } =
    match left with
    | [] -> invalid_arg "move_left"
    | x :: left -> { left ; right = x :: right }

let insert_before x { left ; right } =
    { left = x :: left ; right }

let insert_after x { left ; right } =
    { left ; right = x :: right }

let delete_before { left ; right } =
    match left with
    | [] -> invalid_arg "delete_before"
    | x :: left -> { left ; right }

let delete_after { left ; right } =
    match right with
    | [] -> invalid_arg "delete_after"
    | x :: right -> { left ; right }

let to_list { left ; right } =
    List.rev_append left right

let next { right } =
    match right with
    | [] -> None
    | x :: right -> Some x

let fresh zipper =
    of_list @@ to_list zipper

