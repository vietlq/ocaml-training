open Vfs ;;

print_endline "vfs_tests\n----\n" ;;

print_vfs Nil ;;

print_vfs (File ("myfile.txt", ())) ;;

print_vfs (Dir ("secret", [])) ;;

print_vfs (Dir ("X-Files", [
    File ("Lochness", ()) ;
    Dir ("Hot", [
        File ("UFO", ())
    ])
])) ;;

