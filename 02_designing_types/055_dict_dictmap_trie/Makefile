all: native byte

include ../../defs.mk

native: sanity
	$(OCB) test_dict.native test_dictmap.native test_trie.native

byte: sanity
	$(OCB) test_dict.byte test_dictmap.byte test_trie.byte

profile: sanity
	$(OCB) -tag profile test_dict.native test_dictmap.native test_trie.native

debug: sanity
	$(OCB) -tag debug test_dict.byte test_dictmap.byte test_trie.byte

sanity:
	ocamlfind query unix

test: native
	./test_dict.native
	./test_dictmap.native
	./test_trie.native

.PHONY: all clean native byte profile debug test default

