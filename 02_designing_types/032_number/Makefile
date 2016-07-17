all: native byte

include ../../defs.mk

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

.PHONY: all clean native byte profile debug test default

