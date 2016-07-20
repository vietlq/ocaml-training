open OUnit2 ;;

let test_naivemultiset_add test_ctx =
    let open Naivemultiset in
    let ms = add "a" empty in
    let ms = add "c" ms in
    let ms = add "a" ms in
    let ms = add "b" ms in
    assert (ms = [("c", 1) ; ("b", 1) ; ("a", 2)])

let test_naivemultiset_multiplicity test_ctx =
    let open Naivemultiset in
    let ms = add "a" empty in
    let ms = add "c" ms in
    let ms = add "a" ms in
    let ms = add "b" ms in
    assert (
        (List.fold_right
            (fun elt acc -> multiplicity elt ms :: acc)
            ["a"; "b"; "c"; "d"] [])
        = [2; 1; 1; 0]
    )

let test_multiset_multiplicity test_ctx =
    let module MyMultiSet = Multiset.Make_multiset (String) in
    let open MyMultiSet in
    let ms = add "a" empty in
    let ms = add "c" ms in
    let ms = add "a" ms in
    let ms = add "b" ms in
    assert (
        (List.fold_right
            (fun elt acc -> multiplicity elt ms :: acc)
            ["a"; "b"; "c"; "d"] [])
        = [2; 1; 1; 0]
    )

let test_suite = "test_multisets" >::: [
    "Test Naivemultiset add" >:: test_naivemultiset_add ;
    "Test Naivemultiset multiplicity" >:: test_naivemultiset_multiplicity ;
    "Test Multiset" >:: test_multiset_multiplicity ;
]

let () =
    run_test_tt_main test_suite

