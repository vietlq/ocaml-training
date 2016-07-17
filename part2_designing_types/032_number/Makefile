OCB_FLAGS = -use-ocamlfind
OCB 	  = ocamlbuild $(OCB_FLAGS)

all: native byte

clean:
	$(OCB) -clean

native: sanity
	$(OCB) number_tests.native

byte: sanity
	$(OCB) number_tests.byte

profile: sanity
	$(OCB) -tag profile number_tests.native

debug: sanity
	$(OCB) -tag debug number_tests.byte

sanity:
	ocamlfind query unix

test: native
	./number_tests.native

.PHONY: all clean native byte profile debug test

