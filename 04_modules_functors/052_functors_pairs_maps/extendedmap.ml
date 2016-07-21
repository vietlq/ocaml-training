module Make (Ord : Map.OrderedType) = struct
    include Map.Make (Ord)
    module Set = Set.Make(Ord)

    let of_list l =
        List.fold_left (fun acc (k, v) -> add k v acc) empty l

    let keys t =
        fold (fun k _ set -> Set.add k set) t Set.empty
end

