let empty = []

let rec add elt = function
    | [] -> [ (elt, 1) ]
    | (e, m) :: rest when elt = e -> (e, succ m) :: rest
    | (e, _) as p :: rest when elt > e -> (elt, 1) :: p :: rest
    | p :: rest -> p :: add elt rest

let rec multiplicity elt = function
    | [] -> 0
    | (e, _) :: rest when elt > e -> 0
    | (e, m) :: rest when elt = e -> m
    | _ :: rest -> multiplicity elt rest
