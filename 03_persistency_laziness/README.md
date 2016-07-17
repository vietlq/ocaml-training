## Accumulators & Continuations

*Accumulator* is a common pattern to

* Allow tail recursion and avoid stack overflow
* Define generic iterator like List.fold_left

*Continuation* is a functional parameter of a function, that will be applied to the returned value (instead of simply returning the value)

