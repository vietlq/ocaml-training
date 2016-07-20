open OUnit2 ;;

let test_naivemultiset test_ctx =
    let open Naivemultiset in
    let ms = Naivemultiset.add "a" Naivemultiset.empty in
    let ms = Naivemultiset.add "c" ms in
    let ms = Naivemultiset.add "a" ms in
    let ms = Naivemultiset.add "b" ms in
    assert (ms = [("c", 1) ; ("b", 1) ; ("a", 2)])

let test_suite = "test_multisets" >::: [
    "Test Naivemultiset" >:: test_naivemultiset ;
]

let () =
    run_test_tt_main test_suite

