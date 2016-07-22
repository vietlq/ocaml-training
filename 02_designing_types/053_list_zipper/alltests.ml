open OUnit2 ;;

let test_list_zipper_empty_to_list test_ctx =
    let open Zipper in
    assert (to_list empty = []) ;
    assert (to_list (of_list []) = [])

let test_list_zipper_of_list_to_list test_ctx =
    let open Zipper in
    assert (to_list (of_list [1;2;3]) = [1;2;3])

let test_list_zipper_move_left test_ctx =
    let open Zipper in
    assert (
        match move_left @@ of_list [1;2;3] with
        | exception Invalid_argument s -> s = "move_left"
        | _ -> false
    )

let test_list_zipper_move_right test_ctx =
    let open Zipper in
    assert (to_list @@ move_right @@ of_list [1;2;3] = [1;2;3])

let test_list_zipper_move_right_left test_ctx =
    let open Zipper in
    assert (to_list @@ move_left @@ move_right @@ of_list [1;2;3] = [1;2;3])

let test_suite = "test_multisets" >::: [
    "Zipper Empty-ToList" >:: test_list_zipper_empty_to_list ;
    "Zipper OfList-ToList" >:: test_list_zipper_of_list_to_list ;
    "Zipper MoveLeft" >:: test_list_zipper_move_left ;
    "Zipper MoveRight" >:: test_list_zipper_move_right ;
    "Zipper MoveRightLeft" >:: test_list_zipper_move_right_left ;
]

let () =
    run_test_tt_main test_suite

