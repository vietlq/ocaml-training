all: native byte

include ../../defs.mk

native: sanity
	$(OCB) simple_stream_tests.native

byte: sanity
	$(OCB) simple_stream_tests.byte

profile: sanity
	$(OCB) -tag profile simple_stream_tests.native

debug: sanity
	$(OCB) -tag debug simple_stream_tests.byte

sanity:
	ocamlfind query unix

test: native
	./simple_stream_tests.native

.PHONY: all clean native byte profile debug test default

