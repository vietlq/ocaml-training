## Persistency, Lazy FIFO

The examples in this folder show 3 flavors of persistent FIFO.

### The first - `Naivefifo`

`Naivefifo` is a simple persistent FIFO with following features:

```
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

### The second - `Lazyfrontfifo`

### The third - `Realtimefifo`

