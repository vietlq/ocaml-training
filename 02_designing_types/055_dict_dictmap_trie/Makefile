all: native byte

include ../../defs.mk

native: sanity
	$(OCB) test_dict.native \
		test_dictmap.native \
		test_triestring.native \
		use_dict.native \

byte: sanity
	$(OCB) test_dict.byte \
		test_dictmap.byte \
		test_triestring.byte \
		use_dict.byte \

profile: sanity
	$(OCB) test_dict.native \
		test_dictmap.native \
		test_triestring.native \
		use_dict.native \

debug: sanity
	$(OCB) test_dict.byte \
		test_dictmap.byte \
		test_triestring.byte \
		use_dict.byte \

sanity:
	ocamlfind query unix

test: native
	./test_dict.native
	./test_dictmap.native
	./test_triestring.native

.PHONY: all clean native byte profile debug test default

