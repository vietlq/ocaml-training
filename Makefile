# OCaml build command
OBC=ocamlfind ocamlopt -linkpkg

001: o001_grep_lines.ml
	$(OBC) -package re.posix o001_grep_lines.ml -o 001_grep_lines

002: o002_hello_user.ml
	$(OBC) o002_hello_user.ml -o 002_hello_user

003: o003_random_int.ml
	$(OBC) o003_random_int.ml -o 003_random_int

004: o004_ask_time.ml
	$(OBC) -package unix o004_ask_time.ml -o 004_ask_time

005: o005_count_letters.ml
	$(OBC) o005_count_letters.ml -o 005_count_letters

