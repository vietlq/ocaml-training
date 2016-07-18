## Persistency, Lazy FIFO

The examples in this folder show 3 flavors of persistent FIFO.

### The first - `Naivefifo`

`Naivefifo` is a simple persistent FIFO with following features:

```ocaml
type 'a fifo = {
    front : 'a list ;
    rear  : 'a list
}
```

* Push time is O(1)
* Average pop time is O(1)
* The worst case for pop time is O(n)
* With `fifo = { front = [] ; rear = [1; 2; 3; ...; N] }`:
 * Every time we run `pop fifo`, we always get O(N) time complexity. Not good for persistent FIFO
 * With `_, fifo1 = pop fifo`, whenever we run `pop fifo1`, we always get O(1) time complexity
* We can improve time complexity for subsequent `pop fifo` with laziness

### The second - `Lazyfrontfifo`

`Lazyfrontfifo` presents a slight improvement over `Naivefifo` with using a lazy front list:

```ocaml
type 'a fifo = {
    front      : 'a list ;
    front_len  : int ;
    lazy_front : 'a list lazy_t ;
    rear       : 'a list ;
    rear_len   : int
}
```

* Both push and pop operations are followed by balance checking
* In balance checking, if `front_len <= rear_len`, do:
 * Force computation `front = old_lazy_front = Lazy.force lazy_front`
 * Join rotated rear to the `lazy_front`, like `lazy_front = lazy (old_lazy_front @ List.rev rear)`
 * Empty the `rear`
 * Update `front_len = length of new lazy_front` & `rear_len = 0`
* In balance checking, if `front_len > rear_len`:
 * If `front` is empty, copy from `lazy_front`
 * If not, proceed like normal
* Both push & pop operations have amortized O(1) time complexity
* Both push & pop operations have worst O(n) time complexity
* However, due to laziness and memoization:
 * Unlike `Naivefifo` which has subsequent calls to persistent FIFO is always O(n)
 * `Lazyfrontfifo` guarantees that subsequent calls to persistent FIFO is O(1)
* If length of `front` is `N` and `rear` is `0`, the next time when `Lazy.force` is called is after `N pops`/`N pushes` or `the number of pops + the number of pushes = N`.
* The field `front` is sub-list of `lazy_front`

### The third - `Realtimefifo`

This approach uses 2 streams to cache and amortize cost of push and popping for the FIFO:

```ocaml
type 'a stream = 'a stream_cell lazy_t
and 'a stream_cell = Nil | Cons of 'a * 'a stream

type 'a fifo = {
    front : 'a stream ;
    rear  : 'a list ;
    accu  : 'a stream
}
```

* The field `accu` is a sub-stream of `front`
* Both push & pop have amortized time complexity of O(1)
* Both push & pop are followed by check balance
* Balance checking forces the field `accu` to drop its first element and forces the next cell to appear
* If the field `accu` is empty, then the `rear` is rotated
 * The field `rear` will be empty
 * The contents of `rear` will be transferred to `front` & `accu`
 * Note that in this case `accu` will be `front`
* When popping, both `front` & `accu` will lose their first element
* When pushing, `rear` gets a new element, `front` stays the same, but `accu` loses its first element
* Unlike `Lazyfrontfifo`, in this case `Lazy.force` is called on every push/pop
* Unlike `Lazyfrontfifo` when `rear` is emptied when `rear_len >= front_len`, in this case `rear` is emptied when `len of front = len of rear - 1`
* Thanks to laziness, only the first call to empty `rear` will be O(n) where `n = length of rear`, all subsequent calls are O(1)

