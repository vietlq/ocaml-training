# OCaml build command
OBC=ocamlfind ocamlopt -linkpkg


001: o001_grep_lines.ml
	$(OBC) -package re.posix o001_grep_lines.ml -o o001_grep_lines


