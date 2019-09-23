all: native byte

include ../defs.mk

native: sanity
	$(OCB) min_svg.native

byte: sanity
	$(OCB) min_svg.byte

profile: sanity
	$(OCB) -tag profile min_svg.native

debug: sanity
	$(OCB) -tag debug min_svg.byte

sanity:
	ocamlfind query unix

test: native
	./min_svg.native

.PHONY: all clean native byte profile debug test default

