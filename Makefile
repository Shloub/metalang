#
#  Makefile du projet metalang
#
#  Ce Makefile contient essentiellement les règles pour compiler le projet
#  metalang, ainsi que les règles pour le tester
#
#  usages :
#    make clean
#    make metalang
#    make fastTestCmp
#        lance un test rapide
#    make testCompare
#        lance un teste approfondi
#    make testNotCompile
#        lance les tests qui ne doivent pas compiler
#    make doc
#        compile la documentation
#


tar :
	rm -rf tarball
	@mkdir tarball tarball/Astutils tarball/Eval tarball/Parser tarball/Main tarball/Printers tarball/tools tarball/Stdlib tarball/tests tarball/tests/prog tarball/tests/compile tarball/tests/not_compile || true
	for i in Astutils Eval Main Parser Printers Stdlib tools tests/not_compile tests/prog tests/compile; do \
	echo $$i; \
	find ./$$i -name "*.mllib" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.mly" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.mll" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.mli" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.ml" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.el" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.in" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*.metalang" -exec cp {} tarball/{} \;; \
	find ./$$i -name "*_tags" -exec cp {} tarball/{} \;; \
	done;
	cp _tags tarball/_tags
	cp myocamlbuild.ml tarball/myocamlbuild.ml
	cp Makefile tarball/Makefile
	rm tarball/tests/prog/cambriolage.in
	rm tarball/tests/prog/cambriolage.metalang
	rm tarball/tests/prog/montagnes.in
	rm tarball/tests/prog/montagnes.metalang
	rm tarball/tests/prog/summax_souslist.in
	rm tarball/tests/prog/summax_souslist.metalang
	tar -czf tarball.tar.gz tarball
	rm -rf tarball


java	?=	java
python	?=	python3

CFLAGS ?= -O3
CCFLAGS ?= -O3

TESTSNOTCOMPILEFILES	:= $(basename $(filter %.metalang, \
	$(shell ls tests/not_compile/)))

TESTSFILES	:= $(filter %.metalang, $(shell ls tests/prog/))
TESTS		:= $(addprefix out/, $(basename $(TESTSFILES)))
TESTSDEPS	:= $(addsuffix .test, $(TESTS))

TMPFILES	:=\
	$(addsuffix .eval.out, $(TESTS)) \
	$(addsuffix .c, $(TESTS)) \
	$(addsuffix .c.bin, $(TESTS)) \
	$(addsuffix .c.bin.out, $(TESTS)) \
	$(addsuffix .ml, $(TESTS)) \
	$(addsuffix .ml.out, $(TESTS)) \
	$(addsuffix .ml.native, $(TESTS)) \
	$(addsuffix .ml.native.out, $(TESTS)) \
	$(addsuffix .ml.byte, $(TESTS)) \
	$(addsuffix .ml.byte.out, $(TESTS)) \
	$(addsuffix .java, $(TESTS)) \
	$(addsuffix .java.out, $(TESTS)) \
	$(addsuffix .js, $(TESTS)) \
	$(addsuffix .js.out, $(TESTS)) \
	$(addsuffix .py, $(TESTS)) \
	$(addsuffix .py.out, $(TESTS)) \
	$(addsuffix .php, $(TESTS)) \
	$(addsuffix .php.out, $(TESTS)) \
	$(addsuffix .tex, $(TESTS)) \
	$(addsuffix .tex.out, $(TESTS)) \
	$(addsuffix .exe, $(TESTS)) \
	$(addsuffix .exe.out, $(TESTS)) \
	$(addsuffix .class, $(TESTS)) \
	$(addsuffix .class.out, $(TESTS)) \
	$(addsuffix .cs, $(TESTS)) \
	$(addsuffix .sch, $(TESTS)) \
	$(addsuffix .sch.out, $(TESTS)) \
	$(addsuffix .rb, $(TESTS)) \
	$(addsuffix .rb.out, $(TESTS)) \
	$(addsuffix .cc, $(TESTS)) \
	$(addsuffix .cc.bin, $(TESTS)) \
	$(addsuffix .cc.bin.out, $(TESTS)) \
	$(addsuffix .pas, $(TESTS)) \
	$(addsuffix .pas.bin, $(TESTS)) \
	$(addsuffix .pas.bin.out, $(TESTS)) \
	$(addsuffix .bin.outs, $(TESTS)) \
	$(addsuffix .int.outs, $(TESTS)) \
	$(addsuffix .managed.outs, $(TESTS)) \
	$(addsuffix .startTest, $(TESTS)) \
	$(addsuffix .fastouts, $(TESTS)) \
	$(addsuffix .fasttest, $(TESTS)) \
	$(addsuffix .test, $(TESTS)) \
	$(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)) \
	$(addsuffix .outs, $(TESTS)) \
	$(addsuffix .metalang, $(TESTS))

.SECONDARY: $(TMPFILES)

.PHONY: metalang
metalang : main.byte
	@mv _build/Main/main.byte metalang

main.byte :
	@ocamlbuild -tag debug Main/main.byte
main.native:
	@ocamlbuild Main/main.native

.PHONY: repl.byte
repl.byte :
	@ocamlbuild -tag debug Main/repl.byte


out :
	@mkdir out

out/%.sch : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang sch $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang sch $< || exit 1; \
	fi

out/%.java : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang java $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang java $< || exit 1; \
	fi

out/%.js : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang js $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang js $< || exit 1; \
	fi

out/%.cs : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang cs $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang cs $< || exit 1; \
	fi

out/%.pas : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang pas $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang pas $< || exit 1; \
	fi

out/%.metalang : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang metalang $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang metalang $< || exit 1; \
	fi

out/%.ml : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang ml $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang ml $< || exit 1; \
	fi

out/%.rb : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang rb $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang rb $< || exit 1; \
	fi

out/%.py : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang py $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang py $< || exit 1; \
	fi

out/%.c : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang c $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang c $< || exit 1; \
	fi

out/%.cc : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang cc $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang cc $< || exit 1; \
	fi

out/%.php : tests/prog/%.metalang metalang out
	@echo "generation of $< with entry $(basename $<).compiler_input "
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang php $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang php $< || exit 1; \
	fi

out/%.metalang.test : out/%.startTest out/%.metalang
	@mkdir -p out/foo/out
	@./metalang -nostdlib -quiet -o out/foo/out $(basename $<).metalang
	@for i in `ls $(basename $<).*`; do \
	if [ -e "out/foo/$$i" ]; then \
	if diff "$$i" "out/foo/$$i" &> /dev/null ; then \
		echo "" > /dev/null; \
	else \
		echo "FAIL $^ $$i out/foo/$$i" > $@ \
		echo "$(red)FAIL $^$(reset) $$i out/foo/$$i "; \
		return 1; \
	fi; \
	fi; \
	done;

out/%.c.bin : out/%.c
	@echo "compiling C"
	@gcc $(CFLAGS) $< -o $@ || exit 1

out/%.cc.bin : out/%.cc
	@echo "compiling C++"
	@g++ $(CCFLAGS) $< -o $@ || exit 1

out/%.pas.bin : out/%.pas
	@echo "compiling pascal"
	@fpc $< || exit 1
	@mv out/$(basename $*) $@
	@rm out/$(basename $*).o

out/%.class : out/%.java
	@echo "compiling java"
	@javac $< || exit 1

out/%.exe : out/%.cs
	@echo "compiling C#"
	@gmcs $< || exit 1

out/%.ml.native : out/%.ml
	@echo "compiling ocaml native"
	@ocamlbuild -tag debug out/$(basename $*).native || exit 1
	@mv _build/out/$(basename $*).native $@

out/%.ml.byte : out/%.ml
	@echo "compiling ocaml bytecode"
	@ocamlbuild -tag debug out/$(basename $*).byte || exit 1
	@mv _build/out/$(basename $*).byte $@

out/%.bin.out : out/%.bin
	@echo "testing binary execution"
	@DATE=` date +%s.%N`; \
	./$< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.eval.out : metalang
	@echo "testing metalang execution"
	@DATE=` date +%s.%N`; \
	if [ -e "tests/prog/$(basename $*).compiler_input" ]; then \
		cat "tests/prog/$(basename $*).compiler_input" tests/prog/$(basename $*).in | ./metalang -eval tests/prog/$(basename $*).metalang  > $@ || exit 1; \
	else \
		./metalang -eval tests/prog/$(basename $*).metalang < tests/prog/$(basename $*).in > $@ || exit 1; \
	fi; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.ml.native.out : out/%.ml.native
	@echo "testing ocaml native execution"
	@DATE=` date +%s.%N`; \
	./$< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.ml.byte.out : out/%.ml.byte
	@echo "testing ocaml bytecode execution"
	@DATE=` date +%s.%N`; \
	./$< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.class.out : out/%.class
	@echo "testing java execution"
	@DATE=` date +%s.%N`; \
	$(java) -classpath out $(basename $*) < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.js.out : out/%.js
	@echo "testing javascript execution"
	@DATE=` date +%s.%N`; \
	node $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.ml.out : out/%.ml
	@echo "testing ocaml execution"
	@DATE=` date +%s.%N`; \
	ocaml $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.php.out : out/%.php
	@echo "testing php execution"
	@DATE=` date +%s.%N`; \
	php $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.py.out : out/%.py
	@echo "testing python execution"
	@DATE=` date +%s.%N`; \
	$(python) $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.sch.out : out/%.sch
	@echo "testing scheme execution"
	@DATE=` date +%s.%N`; \
	gsc-script $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.rb.out : out/%.rb
	@echo "testing ruby execution"
	@DATE=` date +%s.%N`; \
	ruby $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

out/%.exe.out : out/%.exe
	@echo "testing mono execution"
	@DATE=` date +%s.%N`; \
	mono $< < tests/prog/$(basename $*).in > $@ || exit 1; \
	DATE2=` date +%s.%N`; \
	echo "$$DATE2 - $$DATE" | bc > $@.time

reset	= \033[0m
red	= \033[0;31m
green	= \033[0;32m
yellow	= \033[0;33m

TESTPROGS	=\
	@for i in $^; do \
	if diff "$$i" "$<" > /dev/null; then \
	echo "" > /dev/null; \
	else \
	echo "-------------------- $$i != $< "; \
	echo "FAIL $^" > $@; \
	echo "$(red)FAIL $^$(reset)"; \
	return 1; \
	fi; \
	done; \
	cp $< $@ ;\

out/%.int.outs : out/%.ml.out out/%.py.out out/%.php.out \
	out/%.rb.out out/%.eval.out out/%.js.out #out/%.sch.out
	$(TESTPROGS)

out/%.bin.outs : out/%.cc.bin.out \
	out/%.c.bin.out out/%.ml.native.out out/%.pas.bin.out
	$(TESTPROGS)

out/%.managed.outs : out/%.class.out out/%.exe.out # out/%.byte.out
	$(TESTPROGS)

out/%.startTest :
	@echo "$(yellow)TESTING $(basename $@)$(reset)"
	@touch $@

out/%.outs : out/%.bin.outs out/%.int.outs out/%.managed.outs
	$(TESTPROGS)

out/%.time.html : out/%.bin.outs out/%.int.outs out/%.managed.outs
	echo "<h3>Bench de : $(basename $@)</h3><table>" > $@
	for i in `ls $(basename $(basename $@))*.time`; do \
	echo "<tr><td>$$i</td><td>`cat $$i`</td></tr>" >> $@; \
	done;
	echo "</table>" >> $@

out/%.test : out/%.startTest out/%.outs
	@echo "$(green)OK $(basename $*)$(reset)";
	@touch $@

%.fastouts : %.int.outs
	$(TESTPROGS)

%.fasttest : %.startTest %.fastouts
	@echo "$(green)OK $(basename $*)$(reset)";
	@touch $@


#never remove tmp files : powerfull for debug
CMPTESTSDEPS	:= $(addsuffix .test, $(TESTS))
.PHONY: testCompare
testCompare : out $(CMPTESTSDEPS)
	@echo "$(green)ALL TESTS OK$(reset)"

FASTTESTSDEPS	:= $(addsuffix .fasttest, $(TESTS))
fastTestCmp : out $(FASTTESTSDEPS)
	@echo "$(green)FAST TESTS OK$(reset)"

%.not_compile : %.startTest metalang
	@rm out/$(notdir $(basename $<)).ml || exit 0
	@./metalang tests/not_compile/$(notdir $(basename $<)).metalang -o out -lang ml || exit 0
	@if [ -e out/$(notdir $(basename $<)).ml ]; then exit 1; fi
	@echo "$(green)OK $(basename $<)$(reset)"
	@touch $@

TESTSNOTCOMPILE	:= $(addprefix out/, \
	$(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)))
.PHONY: testNotCompile
testNotCompile : out $(TESTSNOTCOMPILE)
	@echo "$(green)NOT COMPILE TESTS OK$(reset)"


METATESTSDEPS	:= $(addsuffix .metalang.test, $(TESTS))
metatest : out $(METATESTSDEPS)
	@echo "$(green)METALANG TESTS OK$(reset)"


doc :
	@ocamlbuild metalang.docdir/index.html

libmetalang.cma :
	@ocamlbuild Main/libmetalang.cma

js/test.js : libmetalang.cma
	ocamlc -I +js_of_ocaml -I _build/Main/ -pp "camlp4o js_of_ocaml/pa_js.cmo" str.cma libmetalang.cma js_of_ocaml.cma js/test.ml -o js/test.byte
	js_of_ocaml js/test.byte
	rm js/test.cmo js/test.cmi js/test.byte

js/meta.js : js/test.js
	cat js/header.js js/test.js > js/meta.js

.PHONY: clean
clean :
	@rm -rf out 2> /dev/null || true
	@ocamlbuild -clean
	@echo "OK"
