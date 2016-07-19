(* Extend the implementations using include *)
module Clearable_in_memory_table = struct
    (* Obtain public names/methods from In_memory_table *)
    include In_memory_table
    (* Define own method to extend *)
    let clear { table } = Hashtbl.clear table
end

module Clearable_on_disk_table = struct
    (* Obtain public names/methods from On_disk_table *)
    include On_disk_table
    (* Define own method to extend *)
    let clear { dir } =
        Array.iter
            (fun f -> Unix.unlink (Filename.concat dir f))
            (Sys.readdir dir)
end

module Clearable_cached_table = struct
    (* Obtain public names/methods from Cached_table *)
    include Cached_table
    (* Define own method to extend *)
    let clear (ondisk, inmemory) =
        Clearable_in_memory_table.clear inmemory ;
        Clearable_on_disk_table.clear ondisk
end

