all: native byte

include ../../defs.mk

native: sanity
	$(OCB) vfs_tests.native

byte: sanity
	$(OCB) vfs_tests.byte

profile: sanity
	$(OCB) -tag profile vfs_tests.native

debug: sanity
	$(OCB) -tag debug vfs_tests.byte

sanity:
	ocamlfind query unix

test: native
	./vfs_tests.native

.PHONY: all clean native byte profile debug test default

