(* We take 3 keywords ref, ! and := for granted *)
type 'a ref = { mutable contents : 'a }

let (!) r = r.contents ;;
let (:=) r v = r.contents <- v ;;

