#
#  Makefile du projet metalang
#
#  Ce Makefile contient essentiellement les règles pour compiler le projet
#  metalang, ainsi que les règles pour le tester
#
#  usages :
#    make clean
#    make metalang
#    make testCompare
#        lance un teste approfondi
#    make testNotCompile
#        lance les tests qui ne doivent pas compiler
#    make doc
#        compile la documentation
#

reset	= \033[0m
red	= \033[0;31m
green	= \033[0;32m
yellow	= \033[0;33m

unit:
	ocamlbuild Stdlib/unit.byte
	./unit.byte

.PHONY: cversion
cversion :
	@gcc --version
	@echo "$(green)GCC OK$(reset)";

.PHONY: goversion
goversion :
	@go version
	@echo "$(green)Go OK$(reset)";

.PHONY: ccversion
ccversion :
	@g++ --version
	@echo "$(green)g++ OK$(reset)";

.PHONY: pyversion
pyversion :
	@$(python) --version
	@echo "$(green)Python OK$(reset)";

.PHONY: ocamlversion
ocamlversion :
	@ocaml -version
	@echo "$(green)OCAML OK$(reset)";

.PHONY: javaversion
javaversion :
	@java -version
	@echo "$(green)Java OK$(reset)";

.PHONY: monoversion
monoversion :
	@mono --version
	@echo "$(green)Mono OK$(reset)";

.PHONY: nodeversion
nodeversion :
	@node --version
	@echo "$(green)Node OK$(reset)";

.PHONY: phpversion
phpversion :
	@php --version
	@echo "$(green)PHP OK$(reset)";

.PHONY: commonlispversion
commonlispversion :
	@echo "" | gcl --version
	@echo "$(green)Common Lisp OK$(reset)";

.PHONY: rbversion
rbversion :
	@ruby --version
	@echo "$(green)Ruby OK$(reset)";

.PHONY: pascalversion
pascalversion :
	@fpc --version
	@echo "$(green)Free pascal OK$(reset)";

.PHONY: check-langages
check-langages : cversion goversion ccversion pyversion ocamlversion javaversion monoversion nodeversion phpversion commonlispversion rbversion pascalversion



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
	tar -czf tarball.tar.gz tarball
	rm -rf tarball


java	?=	java
python	?=	python3

OBJCFLAGS ?= -O3 -Wall
CFLAGS ?= -O3 -Wall -lm
CCFLAGS ?= -O3 -Wall

TESTSNOTCOMPILEFILES	:= $(basename $(filter %.metalang, \
	$(shell ls tests/not_compile/)))

COMPILER_SOURCES:= $(shell find . -name "*.ml" -not -path "./out/*" -not -path "./_build/*")

TESTSFILES	:= $(filter %.metalang, $(shell ls tests/prog/))
TESTS		:= $(addprefix out/, $(basename $(TESTSFILES)))
TESTSDEPS	:= $(addsuffix .test, $(TESTS))

TMPFILES	:=\
	$(addsuffix .eval.out, $(TESTS)) \
	$(addsuffix .go, $(TESTS)) \
	$(addsuffix .m, $(TESTS)) \
	$(addsuffix .m.bin, $(TESTS)) \
	$(addsuffix .m.bin.out, $(TESTS)) \
	$(addsuffix .c, $(TESTS)) \
	$(addsuffix .c.bin, $(TESTS)) \
	$(addsuffix .c.bin.out, $(TESTS)) \
	$(addsuffix .hs, $(TESTS)) \
	$(addsuffix .hs.exe, $(TESTS)) \
	$(addsuffix .hs.exe.out, $(TESTS)) \
	$(addsuffix .ml, $(TESTS)) \
	$(addsuffix .ml.out, $(TESTS)) \
	$(addsuffix .ml.native, $(TESTS)) \
	$(addsuffix .ml.native.out, $(TESTS)) \
	$(addsuffix .ml.byte, $(TESTS)) \
	$(addsuffix .ml.byte.out, $(TESTS)) \
	$(addsuffix .pl, $(TESTS)) \
	$(addsuffix .pl.out, $(TESTS)) \
	$(addsuffix .rkt, $(TESTS)) \
	$(addsuffix .rkt.out, $(TESTS)) \
	$(addsuffix .fun.ml, $(TESTS)) \
	$(addsuffix .fun.ml.out, $(TESTS)) \
	$(addsuffix .fun.ml.native, $(TESTS)) \
	$(addsuffix .fun.ml.native.out, $(TESTS)) \
	$(addsuffix .fun.ml.byte, $(TESTS)) \
	$(addsuffix .fun.ml.byte.out, $(TESTS)) \
	$(addsuffix .java, $(TESTS)) \
	$(addsuffix .java.out, $(TESTS)) \
	$(addsuffix .js, $(TESTS)) \
	$(addsuffix .js.out, $(TESTS)) \
	$(addsuffix .py, $(TESTS)) \
	$(addsuffix .py.out, $(TESTS)) \
	$(addsuffix .php, $(TESTS)) \
	$(addsuffix .php.out, $(TESTS)) \
	$(addsuffix .exe, $(TESTS)) \
	$(addsuffix .exe.out, $(TESTS)) \
	$(addsuffix .class, $(TESTS)) \
	$(addsuffix .class.out, $(TESTS)) \
	$(addsuffix .cs, $(TESTS)) \
	$(addsuffix .cl, $(TESTS)) \
	$(addsuffix .cl.out, $(TESTS)) \
	$(addsuffix .rb, $(TESTS)) \
	$(addsuffix .rb.out, $(TESTS)) \
	$(addsuffix .cc, $(TESTS)) \
	$(addsuffix .cc.bin, $(TESTS)) \
	$(addsuffix .cc.bin.out, $(TESTS)) \
	$(addsuffix .go, $(TESTS)) \
	$(addsuffix .go.out, $(TESTS)) \
	$(addsuffix .pas, $(TESTS)) \
	$(addsuffix .pas.bin, $(TESTS)) \
	$(addsuffix .pas.bin.out, $(TESTS)) \
	$(addsuffix .adb, $(TESTS)) \
	$(addsuffix .adb.bin, $(TESTS)) \
	$(addsuffix .adb.bin.out, $(TESTS)) \
	$(addsuffix .test, $(TESTS)) \
	$(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)) \
	$(addsuffix .outs, $(TESTS)) \
	$(addsuffix .metalang_parsed, $(TESTS))

.SECONDARY: $(TMPFILES)

metalang : $(COMPILER_SOURCES) main.byte
	@cp _build/Main/main.byte metalang

main.byte : $(COMPILER_SOURCES)
	@ocamlbuild -tag debug Main/main.byte

main.native : $(COMPILER_SOURCES)
	@ocamlbuild Main/main.native

out/%.m : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang m $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang m $< || exit 1; \
	fi

out/%.cl : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang cl $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang cl $< || exit 1; \
	fi

out/%.go : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang go $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang go $< || exit 1; \
	fi

out/%.java : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang java $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang java $< || exit 1; \
	fi

out/%.js : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang js $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang js $< || exit 1; \
	fi

out/%.cs : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang cs $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang cs $< || exit 1; \
	fi

out/%.pas : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang pas $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang pas $< || exit 1; \
	fi

out/%.adb : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang adb $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang adb $< || exit 1; \
	fi

out/%.metalang_parsed : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang metalang_parsed $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang metalang $< || exit 1; \
	fi

out/%.fun.ml : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang fun.ml $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang fun.ml $< || exit 1; \
	fi

out/%.pl : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang pl $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang pl $< || exit 1; \
	fi

out/%.ml : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang ml $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang ml $< || exit 1; \
	fi

out/%.hs : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang hs $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang hs $< || exit 1; \
	fi

out/%.rb : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang rb $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang rb $< || exit 1; \
	fi

out/%.py : tests/prog/%.metalang metalang Stdlib/stdlib.metalang 
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang py $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang py $< || exit 1; \
	fi

out/%.c : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang c $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang c $< || exit 1; \
	fi

out/%.cc : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang cc $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang cc $< || exit 1; \
	fi

out/%.php : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang php $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang php $< || exit 1; \
	fi

out/%.rkt : tests/prog/%.metalang metalang Stdlib/stdlib.metalang
	@if [ -e "$(basename $<).compiler_input" ]; then \
	./metalang -o out -lang rkt $< < "$(basename $<).compiler_input" || exit 1; \
	else \
	 ./metalang -quiet -o out -lang rkt $< || exit 1; \
	fi

out/%.metalang.test : out/%.metalang Stdlib/stdlib.metalang metalang
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

out/%.m.bin : out/%.m
	@gcc `gnustep-config --objc-flags` -lgnustep-base $(OBJCFLAGS) $< -o $@ || exit 1
	@rm out/$(basename $*).m.d || exit 0

out/%.c.bin : out/%.c
	@gcc $(CFLAGS) $< -o $@ || exit 1

out/%.cc.bin : out/%.cc
	@g++ $(CCFLAGS) $< -o $@ || exit 1

out/%.pas.bin : out/%.pas
	@fpc $< || exit 1
	@mv out/$(basename $*) $@
	@rm out/$(basename $*).o

out/%.adb.bin : out/%.adb
	@gnatmake $< -o $@ || exit 1
	@rm $(basename $*).o
	@rm $(basename $*).ali

out/%.class : out/%.java
	@javac $< || exit 1

out/%.exe : out/%.cs
	@gmcs $< || exit 1

out/%.fun.ml.native : out/%.fun.ml
	@ocamlopt -w +A -g out/$(basename $*).fun.ml -o out/$(basename $*).fun.ml.native || exit 1
	@rm out/$(basename $*).fun.cmx || exit 0
	@rm out/$(basename $*).fun.cmi || exit 0
	@rm out/$(basename $*).fun.o || exit 0

out/%.ml.native : out/%.ml
	@ocamlopt -w +A -g out/$(basename $*).ml -o out/$(basename $*).ml.native || exit 1
	@rm out/$(basename $*).cmx || exit 0
	@rm out/$(basename $*).cmi || exit 0
	@rm out/$(basename $*).o || exit 0

out/%.hs.exe : out/%.hs
	@ghc out/$(basename $*).hs -o out/$(basename $*).hs.exe || exit 1
	@rm out/$(basename $*).o
	@rm out/$(basename $*).hi

out/%.ml.byte : out/%.ml
	@ocamlc -w +A -g out/$(basename $*).ml -o -g out/$(basename $*).ml.byte || exit 1
	@rm out/$(basename $*).cmo || exit 0
	@rm out/$(basename $*).cmi || exit 0

out/%.bin.out : out/%.bin
	./$< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.eval.out : metalang
	@if [ -e "tests/prog/$(basename $*).compiler_input" ]; then \
		cat "tests/prog/$(basename $*).compiler_input" tests/prog/$(basename $*).in | ./metalang -eval tests/prog/$(basename $*).metalang  > $@ || exit 1; \
	else \
		./metalang -eval tests/prog/$(basename $*).metalang < tests/prog/$(basename $*).in > $@ || exit 1; \
	fi;

out/%.ml.native.out : out/%.ml.native
	./$< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.hs.exe.out : out/%.hs.exe
	./$< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.go.out : out/%.go
	go run $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.ml.byte.out : out/%.ml.byte
	./$< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.class.out : out/%.class
	$(java) -classpath out $(basename $*) < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.js.out : out/%.js
	node $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.pl.out : out/%.pl
	perl $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.ml.out : out/%.ml
	ocaml $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.php.out : out/%.php
	php $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.py.out : out/%.py
	$(python) $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.cl.out : out/%.cl
	gcl -f $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.rb.out : out/%.rb
	ruby $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.exe.out : out/%.exe
	mono $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.rkt.out : out/%.rkt
	racket $< < tests/prog/$(basename $*).in > $@ || exit 1;

out/%.test : out/%.adb.bin.out out/%.rkt.out out/%.fun.ml.out out/%.pl.out out/%.rkt.out out/%.m.bin.out out/%.ml.out out/%.py.out out/%.php.out out/%.rb.out out/%.eval.out out/%.js.out out/%.cc.bin.out out/%.c.bin.out out/%.ml.native.out out/%.pas.bin.out out/%.class.out out/%.exe.out out/%.go.out out/%.cl.out out/%.fun.ml.native.out
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
	echo "$(green)OK $(basename $*)$(reset)";

out/%.test_rkt_ml : out/%.rkt.out out/%.fun.ml.out
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

out/%.test_pl_ml : out/%.pl.out out/%.ml.out
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
	echo "$(green)OK $(basename $*)$(reset)";
	echo "$(green)OK $(basename $*)$(reset)";

out/%.test_adb_ml : out/%.adb.bin.out out/%.ml.out
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
	echo "$(green)OK $(basename $*)$(reset)";

testRacket : $(addsuffix .test_rkt_ml, $(TESTS))

testPerl : $(addsuffix .test_pl_ml, $(TESTS))

testAda : $(addsuffix .test_adb_ml, $(TESTS))

%.sources: $(addsuffix .%, $(TESTS))
	@echo "$(green)$@ OK$(reset) $*"
	@echo "ok" > $@

allsources: pl.sources m.sources ml.sources py.sources php.sources rb.sources js.sources cc.sources c.sources pas.sources java.sources rkt.sources fun.ml.sources cs.sources go.sources cl.sources
	@echo "$(green)all sources OK$(reset) $*"
	@echo "ok" > $@

COMPILEMLDEPS := $(addsuffix .ml.native, $(TESTS))
compileML: $(COMPILEMLDEPS)
	@echo "$(green)OCAML COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECMLDEPS := $(addsuffix .ml.native.out, $(TESTS))
execML: $(EXECMLDEPS)
	@echo "$(green)OCAML EXEC OK$(reset)"
	@echo "ok" > $@

COMPILEFUNMLDEPS := $(addsuffix .fun.ml.native, $(TESTS))
compileFUNML: $(COMPILEFUNMLDEPS)
	@echo "$(green)FUN OCAML COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECMLDEPS := $(addsuffix .fun.ml.native.out, $(TESTS))
execFUNML: $(EXECFUNMLDEPS)
	@echo "$(green)FUN OCAML EXEC OK$(reset)"
	@echo "ok" > $@

COMPILECDEPS := $(addsuffix .c.bin, $(TESTS))
compileC: $(COMPILECDEPS)
	@echo "$(green)C COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECCDEPS := $(addsuffix .c.bin.out, $(TESTS))
execC: $(EXECCDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILEPASDEPS := $(addsuffix .pas.bin, $(TESTS))
compilePAS: $(COMPILEPASDEPS)
	@echo "$(green)PASCAL COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECPASDEPS := $(addsuffix .pas.bin.out, $(TESTS))
execPAS: $(EXECPASDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILEADADEPS := $(addsuffix .adb.bin, $(TESTS))
compileADA: $(COMPILEADADEPS)
	@echo "$(green)ADA COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECADADEPS := $(addsuffix .adb.bin.out, $(TESTS))
execADA: $(EXECADADEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILECCDEPS := $(addsuffix .cc.bin, $(TESTS))
compileCC: $(COMPILECCDEPS)
	@echo "$(green)CC COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECCCDEPS := $(addsuffix .cc.bin.out, $(TESTS))
execCC: $(EXECCCDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILEJAVADEPS := $(addsuffix .class, $(TESTS))
compileJAVA: $(COMPILEJAVADEPS)
	@echo "$(green)JAVA COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECJAVADEPS := $(addsuffix .class.out, $(TESTS))
execJAVA: $(EXECJAVADEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILECSDEPS := $(addsuffix .exe, $(TESTS))
compileCS: $(COMPILECSDEPS)
	@echo "$(green)CSHARP COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECCSDEPS := $(addsuffix .exe.out, $(TESTS))
execCS: $(EXECCSDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

COMPILEOBJCDEPS := $(addsuffix .m.bin, $(TESTS))
compileOBJC: $(COMPILEOBJCDEPS)
	@echo "$(green)OBJ-C COMPILATION OK$(reset)"
	@echo "ok" > $@

EXECOBJCDEPS := $(addsuffix .m.bin.out, $(TESTS))
execOBJC: $(EXECOBJCDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECPYDEPS := $(addsuffix .py.out, $(TESTS))
execPY: $(EXECPYDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECRBDEPS := $(addsuffix .rb.out, $(TESTS))
execRB: $(EXECRBDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECPHPDEPS := $(addsuffix .php.out, $(TESTS))
execPHP: $(EXECPHPDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECJSDEPS := $(addsuffix .js.out, $(TESTS))
execJS: $(EXECJSDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECCLDEPS := $(addsuffix .cl.out, $(TESTS))
execCL: $(EXECCLDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECGODEPS := $(addsuffix .go.out, $(TESTS))
execGO: $(EXECGODEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECRKTDEPS := $(addsuffix .rkt.out, $(TESTS))
execRKT: $(EXECRKTDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

EXECPLDEPS := $(addsuffix .pl.out, $(TESTS))
execPL: $(EXECPLDEPS)
	@echo "$(green)@$ OK$(reset)"
	@echo "ok" > $@

compileAll: metalang allsources compilePAS compileADA compileML compileFUNML compilePAS compileC compileCC compileCS compileJAVA compileOBJC
	@echo "$(green)ALL COMPILATION OK$(reset)"
	@echo "ok" > $@

#never remove tmp files : powerfull for debug
CMPTESTSDEPS	:= $(addsuffix .test, $(TESTS))
.PHONY: testCompare
testCompare : compileAll $(CMPTESTSDEPS)
	@echo "$(green)ALL TESTS OK$(reset)"

%.not_compile : metalang
	@rm out/$(notdir $(basename $@)).ml -f || exit 0
	@./metalang tests/not_compile/$(notdir $(basename $@)).metalang -o out -lang ml || exit 0
	@if [ -e out/$(notdir $(basename $@)).ml ]; then exit 1; fi
	@echo "$(green)OK $(notdir $(basename $@))$(reset)"
	@touch $@

TESTSNOTCOMPILE	:= $(addprefix out/, \
	$(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)))
.PHONY: testNotCompile
testNotCompile : metalang out $(TESTSNOTCOMPILE)
	@echo "$(green)NOT COMPILE TESTS OK$(reset)"


METATESTSDEPS	:= $(addsuffix .metalang.test, $(TESTS))
metatest : $(METATESTSDEPS)
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
	@mkdir out
	@ocamlbuild -clean
	@echo "OK"
