open OUnit2 ;;

let test_simplepair_make_left_right test_ctx =
    let module Left = struct type t = int end in
    let module Right = struct type t = string end in
    let module IntStringPair = Assoc.SimplePair (Left) (Right) in
    let open IntStringPair in
    let pair = make 1001 "Misha" in
    let l = left pair in
    let r = right pair in
    assert (l = 1001) ;
    assert (r = "Misha")

let test_pair_make_left_right test_ctx =
    let module Left = struct type t = int end in
    let module Right = struct type t = string end in
    let module IntStringPair = Assoc.Pair (Left) (Right) in
    let open IntStringPair in
    let pair = make 1001 "Misha" in
    let l = left pair in
    let r = right pair in
    assert (l = 1001) ;
    assert (r = "Misha")

let test_suite = "test_multisets" >::: [
    "Assoc.SimplePair Make-Left-Right" >:: test_simplepair_make_left_right ;
    "Assoc.Pair Make-Left-Right" >:: test_pair_make_left_right ;
]

let () =
    run_test_tt_main test_suite

