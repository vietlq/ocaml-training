all: native byte

include ../../defs.mk

native: sanity
	$(OCB) alltests.native usezipper.native

byte: sanity
	$(OCB) alltests.byte usezipper.byte

profile: sanity
	$(OCB) -tag profile alltests.native usezipper.native

debug: sanity
	$(OCB) -tag debug alltests.byte usezipper.byte

sanity:
	ocamlfind query unix

test: native
	./alltests.native

.PHONY: all clean native byte profile debug test default

