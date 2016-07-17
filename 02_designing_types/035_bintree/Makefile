all: native byte

include ../../defs.mk

native:
	$(OCB) bintree_tests.native

byte:
	$(OCB) bintree_tests.byte

profile:
	$(OCB) -tag profile bintree_tests.native

debug:
	$(OCB) -tag debug bintree_tests.byte

test: native
	./bintree_tests.native

.PHONY: all clean native byte profile debug test default

