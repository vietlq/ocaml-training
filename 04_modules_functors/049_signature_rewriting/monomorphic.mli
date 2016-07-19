module type TYPED_TABLE = sig
    type t
    type value
    val init : string -> t
    val put : string -> value -> t -> unit
    val get : string -> t -> value
end

(* Instantiate by rewriting - equivalent to C++ template specialization *)
module Int_table : TYPED_TABLE with type value := int
module Float_table : TYPED_TABLE with type value := float
module String_table : TYPED_TABLE with type value := string

