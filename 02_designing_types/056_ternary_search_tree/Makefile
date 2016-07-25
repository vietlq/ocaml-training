all: native byte

include ../../defs.mk

native: sanity
	$(OCB) \
		test_simple_tst.native \

byte: sanity
	$(OCB) \
		test_simple_tst.byte \

profile: sanity
	$(OCB) \
		test_simple_tst.native \

debug: sanity
	$(OCB) \
		test_simple_tst.byte \

sanity:
	ocamlfind query unix

test: native
	./test_simple_tst.native

.PHONY: all clean native byte profile debug test default

