Source: http://files.meetup.com/1887771/2013-06-06%20Generalized%20Algebraic%20Data%20Types%20%28GADTs%29.html

Play at: https://andrewray.github.io/iocamljs/full402.html

```ocaml
type 'a t = Apply : ('e -> 'a) t * 'e -> 'a t
(** GADT constructor definitions are meant to resemble function signatures.
    ['e] is an existential type because the constructor [Apply] hides it.
*)

type useless = Useless : _ -> useless
let unborked : _ t -> useless = function | Apply (_, arg) -> Useless arg

(**
    Universal types:
    * polymorphic values/functions, polymorphic fields
    * unify with any other type
    * more restrictred implementation
    * less restricted interface
    
    Existential types:
    * first class modules, GADTs, complex encoding with nested polymorphic types
    * unify with no other types
    * less restricted implementation
    * more restricted interface
*)

type absurd = { absurd : 'a. 'a }
type useless = Useless : _ -> useless

let absurd a = a.absurd
let useless e = Useless e

(**
    Convert [absurd] to anything but can't create [absurd]!
    Can convert anything to [useless] but can never inspect [useless]!
*)
```

```ocaml
(**
    type equality: constrain the type's parameters at construction.
    The types are visible to the compiler during pattern matching.
    The constraints are checked at construction.
*)

type _ t =
    | Int : int -> int t
    | String : string -> string t

(** The unifier uses constraints during pattern matching. *)
let extract (type a) (t : a t) : a =
    match t with
    | Int n -> n
    | String s -> s

(** If not all matches specified, they will be treated as errors if called. *)
let extract_string (t : string t) : string =
    match t with
    | String s -> s

let a = extract (Int 3);;
let b = extract (String "abc");;
(** Do not call this to avoid error at compilation time.
    let c = extract_string (Int 4);;
*)
let d = extract_string (String "def");;
```

```ocaml
(**
    Type equality allows us to constrain existential types at construction.
    When pattern matching, this gives the compiler extra information about hidden types.
*)
type _ t =
    | Int : int -> int t
    | String : string -> string t
    | Pair : 'b t * 'c t -> ('b * 'c) t

(**
    This will fail and we need polymorphic recursion to fix it.
let extract (type a) (t : a t) : a =
    match t with
    | Int n -> n
    | String s -> s
    | Pair (t1, t2) -> extract t1, extract t2
*)

(** This solution requires extra newtype a and more unintuitive annotation. *)
let rec clumsy_extract : 'a. 'a t -> 'a =
    fun (type a) (x : a t) ->
        ((match x with
            | Int n -> n
            | String s -> s
            | Pair (t1, t2) -> clumsy_extract t1, clumsy_extract t2) : a)

(** New syntax that combines both polymorphic recursion and newtypes. *)
let rec extract : type a. a t -> a = function
    | Int n -> n
    | String s -> s
    | Pair (t1, t2) -> extract t1, extract t2
```

```ocaml
(** Reify and prove that 2 types are the same. *)
type (_, _) equal = | Refl : ('a, 'a) equal

(** Pattern match to expose that the types are the same *)
let cast (type a) (type b) (Refl : (a, b) equal) (x : a) : b = x

let a = cast (Refl: (int, int) equal);;

(**
    Similar to the GADT [type _ t] above but more runtime cost to represent equality.
    ['a u] is just a normal ADT type. GADT-ness is in the [equal] part.
*)
type 'a u =
    | Int of ('a, int) equal * int
    | String of ('a, string) equal * string

let new_extract (type a) (u : a u) : a =
    match u with
    | Int (Refl, n) -> n
    | String (Refl, s) -> s
```

```ocaml
(**
    When GADTs are useful:
    * Type variables only on the right hand side
    * Internal data structure invariants
    * Smarter exhaustive checks, fewer uses of assert false
    * Data type focused, so best suited for DSLs
*)
```

```ocaml
(** A safer linked list *)
type empty
type nonempty

(** Preserve invariants. We can use phantom type to capture emptiness. *)
type (_, _) safe_list =
    | Nil  : (_, empty) safe_list
    | Cons : 'a * ('a, _) safe_list -> ('a, nonempty) safe_list

(** We no longer require exeptions thrown or option type returned. *)
let hd_safe : ('a, nonempty) safe_list -> 'a = function
    | Cons (x, _) -> x

(**
    Error: This definition has type (int, nonempty) safe_list -> unit
       which is less general than 'a. (int, 'a) safe_list -> unit
let bad_print_head : 'a. (int, 'a) safe_list -> unit
    = fun xs -> Printf.printf "%d\n" (hd_safe xs)
*)

(** Type inference to rescue *)
let print_head xs = Printf.printf "%d\n" (hd_safe xs)

(** Extract type and value more precisely. Can be used at runtime. *)
let nonempty : type e. ('a, e) safe_list -> ('a, nonempty) safe_list option =
    function
    | Nil -> None
    | Cons (_, _) as xs -> Some xs

(** Type inference gets things done nicely. *)
let smart_print_head xs =
    match nonempty xs with
    | None -> Printf.printf "list is empty\n"
    | Some (Cons (x, _)) -> Printf.printf "%d\n" x

(** Instead of returning list with different type, we can confirm its emptiness. *)
let is_nonempty : type e. (_, e) safe_list -> (e, nonempty) equal option =
    function
    | Nil -> None
    | Cons (_, _) -> Some Refl

(** Type inference is not enough, write your annotations.
    Without type annotation, the compiler will both branches of match
    are of the same type (nonempty), which is not useful for us.
*)
let smart_print_head2 : type e. (int, e) safe_list -> unit = fun xs ->
    match is_nonempty xs with
    | None -> Printf.printf "list is empty\n"
    | Some Refl -> Printf.printf "%d\n" (hd_safe xs)

let l0 = Nil;;
let l1 = Cons (1, Nil);;
let l2 = Cons (2, l1);;
(** This won't compile, as expected.
    print_head Nil;;
*)
print_head l1;;
smart_print_head Nil;;
smart_print_head l2;;
smart_print_head2 Nil;;
smart_print_head2 l2;;
```

```ocaml
(** reify = make something abstract to be more conrete or real *)
type _ rep =
    | Int : int rep
    | String : string rep
    | Tuple2 : 'a rep * 'b rep -> ('a * 'b) rep
(**
Typerep is a library for reifying OCaml types as values so you can do some kinds of generic programming over them.

Every distinct value has a unique type (this is an example of a "singleton type").
*)

module Sexp : sig
    type t =
    | Atom of string
    | List of t list
end = struct
    type t =
    | Atom of string
    | List of t list
end

let rec generic_sexp_of : type t. t rep -> (t -> Sexp.t) =
    function
    | Int -> fun num -> Sexp.Atom (Printf.sprintf "%d" num)
    | String -> fun str -> Sexp.Atom str
    | Tuple2 (rep1, rep2) ->
        let f = generic_sexp_of rep1 in
        let g = generic_sexp_of rep2 in
        fun (x, y) -> Sexp.List [f x; g y]

let generic_sexp_of_int_string_pair = generic_sexp_of (Tuple2 (Int, String))

let rec generic_of_sexp : type t. t rep -> (Sexp.t -> t) =
    function
    | Int -> (function
        | Sexp.Atom str -> int_of_string str
        | _ -> failwith "failed to parse int from sexp")
    | String -> (function
        | Sexp.Atom str -> str
        | _ -> failwith "failed to parse string from sexp")
    | Tuple2 (rep1, rep2) ->
        let f = generic_of_sexp rep1 in
        let g = generic_of_sexp rep2 in
        (function
            | Sexp.List [sexp1; sexp2] -> f sexp1, g sexp2
            | _ -> failwith "failed to parse Tuple2 from sexp")
```
