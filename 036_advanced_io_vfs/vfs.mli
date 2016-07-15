type 'a vfs = Nil | File of string * 'a | Dir of string * 'a vfs list
val print_vfs : 'a vfs -> unit
