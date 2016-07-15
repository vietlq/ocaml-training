OCB_FLAGS = -use-ocamlfind
OCB 	  = ocamlbuild $(OCB_FLAGS)

all: native byte

clean:
	$(OCB) -clean

native:
	$(OCB) vfs_tests.native

byte:
	$(OCB) vfs_tests.byte

profile:
	$(OCB) -tag profile vfs_tests.native

debug:
	$(OCB) -tag debug vfs_tests.byte

test:
	./vfs_tests.native

.PHONY: all clean native byte profile debug test

