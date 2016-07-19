module type TYPED_TABLE = sig
    type t
    type value
    val init : string -> t
    val put : string -> value -> t -> unit
    val get : string -> t -> value
end

module Int_table = struct
	(* All definitions of In_memory_table are available *)
	include In_memory_table
	(* Set the correct table type *)
	type t = int table
	(* Wrap In_memory_table.init *)
	let init dir = init string_of_int int_of_string dir
end

module Float_table = struct
	(* All definitions of In_memory_table are available *)
	include In_memory_table
	(* Set the correct table type *)
	type t = float table
	(* Wrap In_memory_table.init *)
	let init dir = init string_of_float float_of_string dir
end

module String_table = struct
	(* All definitions of In_memory_table are available *)
	include In_memory_table
	(* Set the correct table type *)
	type t = string table
	(* Wrap In_memory_table.init *)
	let init dir = init (fun s -> s) (fun s -> s) dir
end

