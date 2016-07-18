all: native byte

include ../../defs.mk

native: sanity
	$(OCB) naivefifo_tests.native

byte: sanity
	$(OCB) naivefifo_tests.byte

profile: sanity
	$(OCB) -tag profile naivefifo_tests.native

debug: sanity
	$(OCB) -tag debug naivefifo_tests.byte

sanity:
	ocamlfind query unix

test: native
	./naivefifo_tests.native

.PHONY: all clean native byte profile debug test default

