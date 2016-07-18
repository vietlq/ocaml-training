## How to build

Here are the steps to build ocaml files

### Manual build using ocamlfind

The tool `ocamlfind` simplifies the following:

* Searching for tools such as `ocamlopt`, `ocamlc`
* Querying existence of libraries for sanity checking
* Install/remove packages
* Use a toolchain

If you know location of tools and packages, feel free to type without `ocamlfind`.

#### To build a single file to an executable

```
ocamlfind ocamlopt o002_hello_user.ml -o 002_hello_user.native
```

#### To build a single file to an executable, now with a package

```
ocamlfind ocamlopt -linkpkg -package re.posix o001_grep_lines.ml -o 001_grep_lines.native
```

#### To generate a `.mli` from a `.ml` file

```
ocamlfind ocamlopt -i bintree.ml > bintree.mli
```

Feel free to edit the newly created `.mli` file.

#### To generate a `.cmx` file from a `.mli` file

```
ocamlfind ocamlopt -c bintree.mli
```

If you have an abstract type, compile with the flag `-opaque` or get warnings:

```
ocamlfind ocamlopt -c -opaque bintree.mli
```

#### To generate a `.cmxa` library file from a `.ml` file

```
ocamlfind ocamlopt -a bintree.ml -o bintree.cmxa
```

#### Now you can happily link in the library file `bintree.cmxa` into your executable

```
ocamlfind ocamlopt bintree.cmxa bintree_tests.ml -o bintree_tests.native
```

### Simple makefile (GNUMake)

Read carefully the manual steps above and then you can write your own makfile.

Some examples of a `Makefile`:

```Makefile
# OCaml build command
OBC       = ocamlfind ocamlopt -linkpkg
OBCI      = ocamlfind ocamlopt -c
OBCA      = ocamlfind ocamlopt -a

bintree: bintree.ml bintree.mli bintree_tests.ml
    $(OBCI) -opaque bintree.mli
    $(OBCA) bintree.ml -o bintree.cmxa
    $(OBC) bintree.cmxa bintree_tests.ml -o bintree_tests

001: o001_grep_lines.ml
    $(OBC) -package re.posix o001_grep_lines.ml -o 001_grep_lines.native

002: o002_hello_user.ml
    $(OBC) o002_hello_user.ml -o 002_hello_user.native

clean:
    rm -rf *.o *.a *.lib
    rm -rf *.cmi *.cmx *.cma *.cmxa
    rm -rf *.bytes *.native
```

### Using ocamlbuild

Note that `ocamlbuild` still finds `ocamlfind` useful and it can be used

Sample makefile that uses `ocamlbuild`:

```Makefile
# Commands for the ocamlbuild interface
OCB_FLAGS = -use-ocamlfind
OCB       = ocamlbuild $(OCB_FLAGS)

all: native byte

clean:
    $(OCB) -clean
    rm -rf *.o *.a *.lib
    rm -rf *.cmi *.cmx *.cma *.cmxa
    rm -rf *.bytes *.native _build

native: sanity
    $(OCB) vfs_tests.native

byte: sanity
    $(OCB) vfs_tests.byte

profile: sanity
    $(OCB) -tag profile -package unix vfs_tests.native

debug: sanity
    $(OCB) -tag debug -package unix vfs_tests.byte

sanity:
    ocamlfind query unix

test: native
    ./vfs_tests.native

.PHONY: all clean native byte profile debug test default
```

Note that currently the commands `profile` & `debug` use `-package unix`. You can keep them brief by moving required packages to the file `_tags` in the same folder with the `Makefile`.

The content of the file `_tags`:

```
true: package(unix)
```

Now you can update `Makefile`:

```Makefile
profile: sanity
    $(OCB) -tag profile vfs_tests.native

debug: sanity
    $(OCB) -tag debug vfs_tests.byte
```

For more info, read:

* https://github.com/ocaml/ocamlbuild/blob/master/manual/manual.adoc
* https://github.com/ocaml/ocamlbuild/blob/master/manual/examples/01-simple
* https://github.com/ocaml/ocamlbuild/blob/master/manual/examples/02-subdirs
* https://github.com/ocaml/ocamlbuild/blob/master/manual/examples/03-packages
* https://github.com/ocaml/ocamlbuild/blob/master/manual/examples/04-library
* https://github.com/ocaml/ocamlbuild/blob/master/manual/examples/05-lex-yacc

### Using OMake

WIP, read more at:

* https://ocaml.org/learn/tutorials/compiling_with_omake.html

