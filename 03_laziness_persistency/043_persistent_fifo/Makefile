all: native byte

include ../../defs.mk

native: sanity
	$(OCB) allfifo_tests.native

byte: sanity
	$(OCB) allfifo_tests.byte

profile: sanity
	$(OCB) -tag profile allfifo_tests.native

debug: sanity
	$(OCB) -tag debug allfifo_tests.byte

sanity:
	ocamlfind query unix

test: native
	./allfifo_tests.native

.PHONY: all clean native byte profile debug test default

