# OCaml build command
OBC = ocamlfind ocamlopt -linkpkg
OBCI = ocamlfind ocamlopt -c
OBCA = ocamlfind ocamlopt -a
PKGC = -package

ML_FILES = o001_grep_lines.ml \
o002_hello_user.ml \
o003_random_int.ml \
o004_ask_time.ml \
o005_count_letters.ml \
o006_ref_name.ml \
o007_array_matrix.ml \
o008_mat_check_zeros.ml \

PKG_001 = re.posix

.PHONY: default

default:
	$(info Pick right build command)

001: o001_grep_lines.ml
	$(OBC) -package re.posix o001_grep_lines.ml -o 001_grep_lines

002: o002_hello_user.ml
	$(OBC) o002_hello_user.ml -o 002_hello_user

003: o003_random_int.ml
	$(OBC) o003_random_int.ml -o 003_random_int

004: o004_ask_time.ml
	$(OBC) -package unix o004_ask_time.ml -o 004_ask_time

005: o005_count_letters.ml
	$(OBC) o005_count_letters.ml -o 005_count_letters

006: o006_ref_name.ml
	$(OBC) o006_ref_name.ml -o 006_ref_name

007: o007_array_matrix.ml
	$(OBC) o007_array_matrix.ml -o 007_array_matrix

008: o008_mat_check_zeros.ml
	$(OBC) o008_mat_check_zeros.ml -o 008_mat_check_zeros

009: o009_record_matches.ml
	$(OBC) o009_record_matches.ml -o 009_record_matches

010: o010_basic_loops.ml
	$(OBC) o010_basic_loops.ml -o 010_basic_loops

011: o011_loop_interval.ml
	$(OBC) o011_loop_interval.ml -o 011_loop_interval

012: o012_store_function.ml
	$(OBC) o012_store_function.ml -o 012_store_function

013: o013_make_generator.ml
	$(OBC) o013_make_generator.ml -o 013_make_generator

014: o014_match_try_recursion.ml
	$(OBC) o014_match_try_recursion.ml -o 014_match_try_recursion

015: o015_beginner_ex1.ml
	$(OBC) o015_beginner_ex1.ml -o 015_beginner_ex1

016: o016_beginner_ex2.ml
	$(OBC) o016_beginner_ex2.ml -o 016_beginner_ex2

017: o017_beginner_ex3.ml
	$(OBC) o017_beginner_ex3.ml -o 017_beginner_ex3

018: o018_beginner_ex4.ml
	$(OBC) o018_beginner_ex4.ml -o 018_beginner_ex4

019: o019_beginner_ex5.ml
	$(OBC) o019_beginner_ex5.ml -o 019_beginner_ex5

020: o020_beginner_ex6.ml
	$(OBC) o020_beginner_ex6.ml -o 020_beginner_ex6

021: o021_beginner_ex7.ml
	$(OBC) o021_beginner_ex7.ml -o 021_beginner_ex7

022: o022_tuples_sample.ml
	$(OBC) o022_tuples_sample.ml -o 022_tuples_sample

023: o023_records_sample.ml
	$(OBC) o023_records_sample.ml -o 023_records_sample

024: o024_mutable_records_sample.ml
	$(OBC) o024_mutable_records_sample.ml -o 024_mutable_records_sample

025: o025_sum_types_basic.ml
	$(OBC) o025_sum_types_basic.ml -o 025_sum_types_basic

026: o026_sum_types_exceptions.ml
	$(OBC) o026_sum_types_exceptions.ml -o 026_sum_types_exceptions

027: o027_sum_types_recursive.ml
	$(OBC) o027_sum_types_recursive.ml -o 027_sum_types_recursive

028: o028_polymorphic_types.ml
	$(OBC) o028_polymorphic_types.ml -o 028_polymorphic_types

030: o030_references.ml
	$(OBC) o030_references.ml -o 030_references

031: o031_redefine_lists.ml
	$(OBC) o031_redefine_lists.ml -o 031_redefine_lists

032: o032_intermediate_ex1.ml
	$(OBC) o032_intermediate_ex1.ml -o 032_intermediate_ex1
	cd o032_intermediate_ex1 && $(OBCI) number.mli && $(OBCA) number.ml -o number

033: o033_intermediate_ex2.ml
	$(OBCI) o033_intermediate_ex2.mli
	$(OBC) o033_intermediate_ex2.ml -o 033_intermediate_ex2

034: o034_intermediate_ex2.ml
	$(OBCI) o034_intermediate_ex2.mli
	$(OBC) o034_intermediate_ex2.ml -o 034_intermediate_ex2

035: o035_intermediate_ex3.ml
	$(OBCI) o035_intermediate_ex3.mli
	$(OBC) o035_intermediate_ex3.ml -o 035_intermediate_ex3

clean:
	rm -rf *.o *.cmi *.cmx *.cma *.a *.lib *.cmxa _build

