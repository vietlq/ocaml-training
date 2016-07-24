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

let is_not_found s dictmap =
    match Dictmap.get s dictmap with
    | exception Not_found -> true
    | _ -> false

let test_dictmap_empty test_ctx =
    let open Dictmap in
    assert (present "" empty = false) ;
    assert (present "a" empty = false) ;
    assert (present "b" empty = false) ;
    assert (present "c" empty = false) ;
    assert (present "d" empty = false) ;
    assert (present "e" empty = false) ;
    assert (present "ab" empty = false) ;
    assert (present "abc" empty = false) ;
    assert (present "bcd" empty = false) ;
    assert (present "abcd" empty = false) ;
    assert (is_not_found "" empty) ;
    assert (is_not_found "a" empty) ;
    assert (is_not_found "b" empty) ;
    assert (is_not_found "c" empty) ;
    assert (is_not_found "d" empty) ;
    assert (is_not_found "e" empty) ;
    assert (is_not_found "ab" empty) ;
    assert (is_not_found "abc" empty) ;
    assert (is_not_found "bcd" empty) ;
    assert (is_not_found "abcd" empty)

let test_dictmap_insert_present_simple test_ctx =
    let open Dictmap in
    let tree = set "abcd" 1234 empty in
    assert (present "" tree = false) ;
    assert (present "a" tree = false) ;
    assert (present "b" tree = false) ;
    assert (present "c" tree = false) ;
    assert (present "d" tree = false) ;
    assert (present "e" tree = false) ;
    assert (present "ab" tree = false) ;
    assert (present "abc" tree = false) ;
    assert (present "bcd" tree = false) ;
    assert (present "abcd" tree) ;
    assert (is_not_found "" tree) ;
    assert (is_not_found "a" tree) ;
    assert (is_not_found "b" tree) ;
    assert (is_not_found "c" tree) ;
    assert (is_not_found "d" tree) ;
    assert (is_not_found "e" tree) ;
    assert (is_not_found "ab" tree) ;
    assert (is_not_found "abc" tree) ;
    assert (is_not_found "bcd" tree) ;
    assert (get "abcd" tree = 1234)

let test_dictmap_insert_present_branches test_ctx =
    let open Dictmap in
    let tree = set "abcd" 1234 empty in
    let tree = set "bcd" 234 tree in
    let tree = set "abc" 123 tree in
    let tree = set "b" 2 tree in
    let tree = set "a" 1 tree in
    assert (present "" tree = false) ;
    assert (present "a" tree) ;
    assert (present "b" tree) ;
    assert (present "c" tree = false) ;
    assert (present "d" tree = false) ;
    assert (present "e" tree = false) ;
    assert (present "ab" tree = false) ;
    assert (present "abc" tree) ;
    assert (present "bcd" tree) ;
    assert (present "abcd" tree) ;
    assert (is_not_found "" tree) ;
    assert (is_not_found "c" tree) ;
    assert (is_not_found "d" tree) ;
    assert (is_not_found "e" tree) ;
    assert (is_not_found "ab" tree) ;
    assert (get "a" tree = 1) ;
    assert (get "b" tree = 2) ;
    assert (get "abc" tree = 123) ;
    assert (get "bcd" tree = 234) ;
    assert (get "abcd" tree = 1234)

let test_dictmap_insert_invalid_arg test_ctx =
    let open Dictmap in
    let tree = set "abcd" 1234 empty in
    let tree = set "bcd" 234 tree in
    let tree = set "abc" 123 tree in
    let tree = set "b" 2 tree in
    let tree = set "a" 1 tree in
    assert (
        match set "" 0 tree with
        | exception Invalid_argument _ -> true
        | d -> false
    )

let test_suite = "test_multisets" >::: [
    (* Test cases for Dict *)
    "Dict Empty" >:: test_dict_empty ;
    "Dict Insert-Present Simple" >:: test_dict_insert_present_simple ;
    "Dict Insert-Present Branches" >:: test_dict_insert_present_branches ;
    "Dict Insert Invalid_argument" >:: test_dict_insert_invalid_arg ;

    (* Test cases for Dictmap *)
    "Dictmap Empty" >:: test_dictmap_empty ;
    "Dictmap Insert-Present Simple" >:: test_dictmap_insert_present_simple ;
    "Dictmap Insert-Present Branches" >:: test_dictmap_insert_present_branches ;
    "Dictmap Insert Invalid_argument" >:: test_dictmap_insert_invalid_arg ;
]

let () =
    run_test_tt_main test_suite

