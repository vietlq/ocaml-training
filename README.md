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

### Simple makefile (GNUMake)

### Using ocamlbuild

### Using OMake

