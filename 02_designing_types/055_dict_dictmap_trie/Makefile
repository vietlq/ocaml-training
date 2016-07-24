all: native byte

include ../../defs.mk

native: sanity
	$(OCB) alltests.native usedict.native

byte: sanity
	$(OCB) alltests.byte usedict.byte

profile: sanity
	$(OCB) -tag profile alltests.native usedict.native

debug: sanity
	$(OCB) -tag debug alltests.byte usedict.byte

sanity:
	ocamlfind query unix

test: native
	./alltests.native

.PHONY: all clean native byte profile debug test default

