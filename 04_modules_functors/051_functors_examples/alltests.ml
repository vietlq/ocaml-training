open OUnit2 ;;

let test_naivemultiset_add test_ctx =
    let open Naivemultiset in
    let ms = Naivemultiset.add "a" Naivemultiset.empty in
    let ms = Naivemultiset.add "c" ms in
    let ms = Naivemultiset.add "a" ms in
    let ms = Naivemultiset.add "b" ms in
    assert (ms = [("c", 1) ; ("b", 1) ; ("a", 2)])

let test_naivemultiset_multiplicity test_ctx =
    let open Naivemultiset in
    let ms = Naivemultiset.add "a" Naivemultiset.empty in
    let ms = Naivemultiset.add "c" ms in
    let ms = Naivemultiset.add "a" ms in
    let ms = Naivemultiset.add "b" ms in
    assert (
        (List.fold_right
            (fun elt acc -> Naivemultiset.multiplicity elt ms :: acc)
            ["a"; "b"; "c"; "d"] [])
        = [2; 1; 1; 0]
    )

let test_suite = "test_multisets" >::: [
    "Test Naivemultiset" >:: test_naivemultiset_add ;
    "Test Naivemultiset" >:: test_naivemultiset_multiplicity ;
]

let () =
    run_test_tt_main test_suite

