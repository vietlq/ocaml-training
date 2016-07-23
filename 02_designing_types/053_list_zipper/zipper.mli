type 'a list_zipper
val of_list : 'a list -> 'a list_zipper
val move_right : 'a list_zipper -> 'a list_zipper
val move_left : 'a list_zipper -> 'a list_zipper
val insert_before : 'a -> 'a list_zipper -> 'a list_zipper
val insert_after : 'a -> 'a list_zipper -> 'a list_zipper
val delete_before : 'a list_zipper -> 'a list_zipper
val delete_after : 'a list_zipper -> 'a list_zipper
val to_list : 'a list_zipper -> 'a list
val next : 'a list_zipper -> 'a option
val fresh : 'a list_zipper -> 'a list_zipper
