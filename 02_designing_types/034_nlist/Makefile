OCB_FLAGS = -use-ocamlfind
OCB 	  = ocamlbuild $(OCB_FLAGS)

all: native byte

clean:
	$(OCB) -clean

native: sanity
	$(OCB) nlist_tests.native

byte: sanity
	$(OCB) nlist_tests.byte

profile: sanity
	$(OCB) -tag profile nlist_tests.native

debug: sanity
	$(OCB) -tag debug nlist_tests.byte

sanity:
	ocamlfind query unix

test: native
	./nlist_tests.native

.PHONY: all clean native byte profile debug test

