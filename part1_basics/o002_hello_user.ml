let greetings name =
    match name with
    | "" -> "env[USER] not set!"
    | valid_name -> "Hello " ^ String.capitalize_ascii valid_name ^ "!";;
let name =
    Sys.getenv "USER";;
print_endline (greetings name);;
