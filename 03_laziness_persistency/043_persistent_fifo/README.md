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
* 

### The second - `Lazyfrontfifo`

### The third - `Realtimefifo`

