include ../defs.mk

.PHONY: bintree

.DEFAULT: bintree

bintree: bintree.mli bintree.ml bintree_tests.ml
	$(OBCI) -opaque bintree.mli
	$(OBCA) bintree.ml -o bintree.cmxa
	$(OBC) bintree.cmxa bintree_tests.ml -o bintree_tests
