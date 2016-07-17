# OCaml build command
OBC = ocamlfind ocamlopt -linkpkg
OBCI = ocamlfind ocamlopt -c
OBCA = ocamlfind ocamlopt -a
PKGC = -package

.PHONY: default

default:
	$(info Pick right build command)

clean:
	rm -rf *.o *.a *.lib
	rm -rf *.cmi *.cmx *.cma *.cmxa
	rm -rf *.bytes *.native _build
