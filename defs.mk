# OCaml build command
OBC       = ocamlfind ocamlopt -linkpkg
OBCI      = ocamlfind ocamlopt -c
OBCA      = ocamlfind ocamlopt -a

# Commands for the ocamlbuild interface
OCB_FLAGS = -use-ocamlfind
OCB       = ocamlbuild $(OCB_FLAGS)

.PHONY: default

default:
	$(info Pick right build command)

clean:
	$(OCB) -clean
	rm -rf *.o *.a *.lib
	rm -rf *.cmi *.cmx *.cma *.cmxa
	rm -rf *.byte *.native _build
