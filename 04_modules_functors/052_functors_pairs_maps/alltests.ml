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

let test_assoc_set_get_unset test_ctx =
    let module Left = struct type t = int end in
    let module Right = struct type t = string end in
    let module Pair = Assoc.Pair (Left) (Right) in
    let module IntStringAssoc = Assoc.Assoc (Pair) in
    let open IntStringAssoc in
    let assoc = set 1001 "Misha" empty in
    let assoc = set 1002 "Galaxy" assoc in
    let newassoc = set 1002 "Universe" assoc in
    let oldassoc = unset 1001 assoc in
    assert (get 1001 assoc = "Misha") ;
    assert (get 1002 assoc = "Galaxy") ;
    assert (get 1002 newassoc = "Universe") ;
    assert ((
        try
            get 1001 oldassoc
        with
        | Not_found ->
            Printf.eprintf "get 1001 assoc ==> Not_found\n" ;
            "NOT_FOUND!"
        )
        = "NOT_FOUND!"
    ) ;
    assert ((
        match get 1003 assoc
        with
        | exception Not_found ->
            Printf.eprintf "get 1003 assoc ==> Not_found\n" ;
            "NOT_FOUND!"
        | s -> s
        )
        = "NOT_FOUND!"
    )

let test_suite = "test_multisets" >::: [
    "Assoc.SimplePair Make-Left-Right" >:: test_simplepair_make_left_right ;
    "Assoc.Pair Make-Left-Right" >:: test_pair_make_left_right ;
    "Assoc.Assoc Set-Get-Unset" >:: test_assoc_set_get_unset ;
]

let () =
    run_test_tt_main test_suite

