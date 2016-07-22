all: native byte

include ../../defs.mk

native: sanity
	$(OCB) alltests.native

byte: sanity
	$(OCB) alltests.byte

profile: sanity
	$(OCB) -tag profile alltests.native

debug: sanity
	$(OCB) -tag debug alltests.byte

sanity:
	ocamlfind query unix

test: native
	./alltests.native

.PHONY: all clean native byte profile debug test default

