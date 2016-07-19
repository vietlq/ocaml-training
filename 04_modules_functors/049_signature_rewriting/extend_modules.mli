(* The previous tables do no have a function to clear entries, we can add now *)
module type CLEARABLE_TABLE = sig
    (* Copy all interface items from TABLE *)
    include TABLE
    (* Add extra method *)
    val clear : 'a table -> unit
end

(* Now declare new interfaces with specific parameters *)
module Clearable_in_memory_table : CLEARABLE_TABLE with type param := unit
module Clearable_on_disky_table : CLEARABLE_TABLE with type param := string
module Clearable_cached_table : CLEARABLE_TABLE with type param := string

