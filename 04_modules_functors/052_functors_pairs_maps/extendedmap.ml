module Extend_map (Ord : Map.OrderedType) = struct
    include Map.Make (Ord)
    let of_list l =
        List.fold_left (fun acc (k, v) -> add k v acc) empty l
end

