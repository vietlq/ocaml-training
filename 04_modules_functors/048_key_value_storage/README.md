## Variations on a (key x value) table

* Build a quick-n-dirty on-disk (key x value) storage
* Make the value type polymorphic by requiring serializers
* Write an interface for it
* Write a simple in-memory storage
* Combine both into cached disk storage
* Make 3 implementations available as three modules with the same interface

### Naive implementation

Check `naivekv.mli` & `naivekv.ml` for details:

```ocaml
val init : string -> unit
val put : string -> 'a -> ('a -> string) -> string -> unit
val get : string -> (string -> 'a) -> string -> 'a
```

### Improved On-disk implementation

Check `ondiskkv.mli` & `ondiskkv.ml` for details:

```ocaml
type 'a table
val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
val put : string -> 'a -> 'a table -> unit
val get : string -> 'a table -> 'a
```

### In-memory implementation

Check `inmemorykv.mli` & `inmemorykv.ml` for details:

```ocaml
type 'a table
val init : ('a -> string) -> (string -> 'a) -> 'b -> 'a table
val put : string -> 'a -> 'a table -> unit
val get : string -> 'a table -> 'a
```

Ideally for `In_memory_table.init`, we want to have the last param to be of type `unit` and not `string` and then omitted. To achieve this, we will need interface rewriting in the next part.

### Basic mixed module of on-disk & in-memory implementations

Check `basicmixedkv.mli` & `basicmixedkv.ml` for details:

```ocaml
module On_disk_table :
  sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

module In_memory_table :
  sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

(* In the .ml file *)

module On_disk_table = struct ... end

module In_memory_table = struct ... end

```

### Mixed on-disk & in-memory implementations with the same module type API

Check `newmixedkv.mli` & `newmixedkv.ml` for details:

```ocaml
module type TABLE = sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
end

module On_disk_table : TABLE

module In_memory_table : TABLE

(* In the .ml file *)
module On_disk_table = struct ... end
module In_memory_table = struct ... end

(* You can do this too *)
module On_disk_table : TABLE = struct ... end
module In_memory_table : TABLE = struct ... end
```

### Flexible cache using the same API & combining on-disk & in-memory

Check `flexiblekv.mli` & `flexiblekv.ml` for details:

```ocaml
module type TABLE =
  sig
    type 'a table
    val init : ('a -> string) -> (string -> 'a) -> string -> 'a table
    val put : string -> 'a -> 'a table -> unit
    val get : string -> 'a table -> 'a
  end

module On_disk_table : TABLE

module In_memory_table : TABLE

module Cache_table : TABLE

(* In the .ml file *)
module On_disk_table = struct ... end
module In_memory_table = struct ... end
module Cache_table = struct ... end

(* You can do this too *)
module On_disk_table : TABLE = struct ... end
module In_memory_table : TABLE = struct ... end
module Cache_table : TABLE = struct ... end
```

Ideally for `In_memory_table.init`, we want to have the last param to be of type `unit` and not `string` and then omitted. To achieve this, we will need interface rewriting in the next part.

