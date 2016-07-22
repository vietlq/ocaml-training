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

let test_list_zipper_delete_before test_ctx =
    let open Zipper in
    assert (
        match delete_before @@ of_list [1;2;3] with
        | exception Invalid_argument s -> s = "delete_before"
        | _ -> false
    )

let test_list_zipper_delete_after test_ctx =
    let open Zipper in
    assert (to_list @@ delete_after @@ of_list [1;2;3] = [2;3])

let test_list_zipper_move_right_delete_before test_ctx =
    let open Zipper in
    assert (to_list @@ delete_before @@ move_right @@ of_list [1;2;3] = [2;3])

let test_suite = "test_multisets" >::: [
    "Zipper Empty-ToList" >:: test_list_zipper_empty_to_list ;
    "Zipper OfList-ToList" >:: test_list_zipper_of_list_to_list ;
    "Zipper MoveLeft" >:: test_list_zipper_move_left ;
    "Zipper MoveRight" >:: test_list_zipper_move_right ;
    "Zipper MoveRightLeft" >:: test_list_zipper_move_right_left ;
    "Zipper DeleteBefore" >:: test_list_zipper_delete_before ;
    "Zipper DeleteAfter" >:: test_list_zipper_delete_after ;
    "Zipper MoveRight-DeleteBefore" >:: test_list_zipper_move_right_delete_before ;
]

let () =
    run_test_tt_main test_suite

