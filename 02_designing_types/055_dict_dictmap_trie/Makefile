all: native byte

include ../../defs.mk

native: sanity
	$(OCB) test_dict.native test_dictmap.native

byte: sanity
	$(OCB) test_dict.byte test_dictmap.byte

profile: sanity
	$(OCB) -tag profile test_dict.native test_dictmap.native

debug: sanity
	$(OCB) -tag debug test_dict.byte test_dictmap.byte

sanity:
	ocamlfind query unix

test: native
	./test_dict.native
	./test_dictmap.native

.PHONY: all clean native byte profile debug test default

