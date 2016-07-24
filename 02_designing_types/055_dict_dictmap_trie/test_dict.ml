open OUnit2 ;;

let test_dict_empty test_ctx =
    let open Dict in
    assert (present "" empty = false) ;
    assert (present "a" empty = false) ;
    assert (present "b" empty = false) ;
    assert (present "c" empty = false) ;
    assert (present "d" empty = false) ;
    assert (present "e" empty = false) ;
    assert (present "ab" empty = false) ;
    assert (present "abc" empty = false) ;
    assert (present "bcd" empty = false) ;
    assert (present "abcd" empty = false)

let test_dict_insert_present_simple test_ctx =
    let open Dict in
    let tree = insert "abcd" empty in
    assert (present "" tree = false) ;
    assert (present "a" tree = false) ;
    assert (present "b" tree = false) ;
    assert (present "c" tree = false) ;
    assert (present "d" tree = false) ;
    assert (present "e" tree = false) ;
    assert (present "ab" tree = false) ;
    assert (present "abc" tree = false) ;
    assert (present "bcd" tree = false) ;
    assert (present "abcd" tree)

let test_dict_insert_present_branches test_ctx =
    let open Dict in
    let tree = insert "abcd" empty in
    let tree = insert "bcd" tree in
    let tree = insert "abc" tree in
    let tree = insert "b" tree in
    let tree = insert "a" tree in
    assert (present "" tree = false) ;
    assert (present "a" tree) ;
    assert (present "b" tree) ;
    assert (present "c" tree = false) ;
    assert (present "d" tree = false) ;
    assert (present "e" tree = false) ;
    assert (present "ab" tree = false) ;
    assert (present "abc" tree) ;
    assert (present "bcd" tree) ;
    assert (present "abcd" tree)

let test_dict_insert_invalid_arg test_ctx =
    let open Dict in
    let tree = insert "abcd" empty in
    let tree = insert "bcd" tree in
    let tree = insert "abc" tree in
    let tree = insert "b" tree in
    let tree = insert "a" tree in
    assert (
        match insert "" tree with
        | exception Invalid_argument _ -> true
        | d -> false
    )

let test_suite = "test_multisets" >::: [
    "Dict Empty" >:: test_dict_empty ;
    "Dict Insert-Present Simple" >:: test_dict_insert_present_simple ;
    "Dict Insert-Present Branches" >:: test_dict_insert_present_branches ;
    "Dict Insert Invalid_argument" >:: test_dict_insert_invalid_arg ;
]

let () =
    run_test_tt_main test_suite

