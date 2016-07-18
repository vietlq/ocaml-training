open OUnit2 ;;

let test_naivefifo_push test_ctx =
    let open Naivefifo in
    let fifo = empty in
    let fifo1 = push 1 fifo in
    let fifo2 = push 2 fifo1 in
    let fifo3 = push 3 fifo2 in
    let x1, _ = pop fifo1 in
    let x2, _ = pop fifo2 in
    let x3, _ = pop fifo3 in
    assert_equal 1 x1 ;
    assert_equal 1 x2 ;
    assert_equal 1 x3

let test_naivefifo_pop test_ctx =
    let open Naivefifo in
    let fifo = empty in
    let fifo = push 1 fifo in
    let fifo = push 2 fifo in
    let fifo = push 3 fifo in
    let _, _ = pop fifo in
    let _, _ = pop fifo in
    let x, fifo_3 = pop fifo in
    let y, fifo_4 = pop fifo_3 in
    let z, fifo_5 = pop fifo_4 in
    assert_equal (x, y, z) (1, 2, 3)

let test_lazyfrontfifo_push test_ctx =
    let open Lazyfrontfifo in
    let fifo = empty in
    let fifo1 = push 1 fifo in
    let fifo2 = push 2 fifo1 in
    let fifo3 = push 3 fifo2 in
    let x1, _ = pop fifo1 in
    let x2, _ = pop fifo2 in
    let x3, _ = pop fifo3 in
    assert_equal 1 x1 ;
    assert_equal 1 x2 ;
    assert_equal 1 x3

let test_lazyfrontfifo_pop test_ctx =
    let open Lazyfrontfifo in
    let fifo = empty in
    let fifo = push 1 fifo in
    let fifo = push 2 fifo in
    let fifo = push 3 fifo in
    let _, _ = pop fifo in
    let _, _ = pop fifo in
    let x, fifo_3 = pop fifo in
    let y, fifo_4 = pop fifo_3 in
    let z, fifo_5 = pop fifo_4 in
    assert_equal (x, y, z) (1, 2, 3)

let test_realtimefifo_push test_ctx =
    let open Realtimefifo in
    let fifo = empty in
    let fifo1 = push 1 fifo in
    let fifo2 = push 2 fifo1 in
    let fifo3 = push 3 fifo2 in
    let x1, _ = pop fifo1 in
    let x2, _ = pop fifo2 in
    let x3, _ = pop fifo3 in
    assert_equal 1 x1 ;
    assert_equal 1 x2 ;
    assert_equal 1 x3

let test_realtimefifo_pop test_ctx =
    let open Realtimefifo in
    let fifo = empty in
    let fifo = push 1 fifo in
    let fifo = push 2 fifo in
    let fifo = push 3 fifo in
    let _, _ = pop fifo in
    let _, _ = pop fifo in
    let x, fifo_3 = pop fifo in
    let y, fifo_4 = pop fifo_3 in
    let z, fifo_5 = pop fifo_4 in
    assert_equal (x, y, z) (1, 2, 3)

let test_suite = "test_naivefifo" >::: [
    "Test Naivefifo push" >:: test_naivefifo_push ;
    "Test Naivefifo pop" >:: test_naivefifo_pop ;
    "Test Lazyfrontfifo push" >:: test_lazyfrontfifo_push ;
    "Test Lazyfrontfifo pop" >:: test_lazyfrontfifo_pop ;
    "Test Realtimefifo push" >:: test_realtimefifo_push ;
    "Test Realtimefifo pop" >:: test_realtimefifo_pop ;
]

let () =
    run_test_tt_main test_suite
;;

