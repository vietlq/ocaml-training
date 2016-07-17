If you would like to build using make only, without ocamlbuild:

```Makefile
# Makefile
# OCaml build command
OBC = ocamlfind ocamlopt -linkpkg
OBCI = ocamlfind ocamlopt -c
OBCA = ocamlfind ocamlopt -a
$(OBCI) -opaque bintree.mli
$(OBCA) bintree.ml -o bintree.cmxa
$(OBC) bintree.cmxa bintree_tests.ml -o bintree_tests
```
