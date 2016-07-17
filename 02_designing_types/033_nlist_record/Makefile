all: native byte

include ../../defs.mk

native: sanity
	$(OCB) nlistrec_tests.native

byte: sanity
	$(OCB) nlistrec_tests.byte

profile: sanity
	$(OCB) -tag profile nlistrec_tests.native

debug: sanity
	$(OCB) -tag debug nlistrec_tests.byte

sanity:
	ocamlfind query unix

test: native
	./nlistrec_tests.native

.PHONY: all clean native byte profile debug test default

