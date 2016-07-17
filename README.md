## Code for OCaml Training & Practices

## How to build

Here are the steps to build ocaml files

### Manual build using ocamlfind

The tool `ocamlfind` simplifies the following:

* Searching for tools such as `ocamlopt`, `ocamlc`
* Querying existence of libraries for sanity checking
* Install/remove packages
* Use a toolchain

If you know location of tools and packages, feel free to type without `ocamlfind`.

To build a single file to an executable:

```
ocamlfind ocamlopt o002_hello_user.ml -o 002_hello_user.native
```

To build a single file to an executable, now with a package:

```
ocamlfind ocamlopt -linkpkg -package re.posix o001_grep_lines.ml -o 001_grep_lines.native
```

To generate a `.mli` from a `.ml` file:

```
ocamlfind ocamlopt -i bintree.ml > bintree.mli
```

Feel free to edit the newly created `.mli` file.

To generate a `.cmx` file from a `.mli` file:

```
ocamlfind ocamlopt -c bintree.mli
```

If you have an abstract type, compile with the flag `-opaque` or get warnings:

```
ocamlfind ocamlopt -c -opaque bintree.mli
```

To generate a `.cmxa` library file from a `.ml` file:

```
ocamlfind ocamlopt -a bintree.ml -o bintree.cmxa
```

Now you can happily link in the library file `bintree.cmxa` into your executable:

```
ocamlfind ocamlopt bintree.cmxa bintree_tests.ml -o bintree_tests.native
```

### Simple makefile (GNUMake)

### Using ocamlbuild

### Using OMake

