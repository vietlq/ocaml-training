# OCaml build command
OBC=ocamlfind ocamlopt -linkpkg

001: o001_grep_lines.ml
	$(OBC) -package re.posix o001_grep_lines.ml -o 001_grep_lines

002: o002_hello_user.ml
	$(OBC) o002_hello_user.ml -o 002_hello_user

