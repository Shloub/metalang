
java	?=	java
python	?=	python3

TESTSNOTCOMPILEFILES	:= $(basename $(filter %.metalang, $(shell ls tests/not_compile/)))

TESTSFILES	:= $(filter %.metalang, $(shell ls tests/prog/))
TESTS		:= $(addprefix out/, $(basename $(TESTSFILES)))
TESTSDEPS	:= $(addsuffix .test, $(TESTS))

TMPFILES	:=\
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
	$(addsuffix .bin.outs, $(TESTS)) \
	$(addsuffix .int.outs, $(TESTS)) \
	$(addsuffix .managed.outs, $(TESTS)) \
	$(addsuffix .startTest, $(TESTS)) \
	$(addsuffix .fastouts, $(TESTS)) \
	$(addsuffix .fasttest, $(TESTS)) \
	$(addsuffix .test, $(TESTS)) \
	$(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)) \
	$(addsuffix .outs, $(TESTS))

.SECONDARY: $(TMPFILES)

GEN	= \
	@./metalang $< || exit 1

.PHONY: metalang
metalang : main.byte
	@mv _build/Main/main.byte metalang
main.byte :
	@ocamlbuild -lflag -g -cflag -g Main/main.byte

.PHONY: repl.byte
repl.byte :
	@ocamlbuild -lflag -g -cflag -g Main/repl.byte


out :
	@mkdir out

out/%.c out/%.cc out/%.php out/%.py out/%.ml out/%.rb \
out/%.sch out/%.java out/%.cs: tests/prog/%.metalang metalang out
	$(GEN)
	@for f in `ls $(notdir $*).*`; do mv $$f out/$$f ; done

TESTBASENAME	= `echo "$<" | cut -d . -f 1`


out/%.c.bin : out/%.c
	@gcc $< -o $@ || exit 1

out/%.cc.bin : out/%.cc
	@g++ $< -o $@ || exit 1

out/%.class : out/%.java
	@javac $< || exit 1

out/%.exe : out/%.cs
	@gmcs $< || exit 1

out/%.ml.native : out/%.ml
	@ocamlbuild out/$(basename $*).native || exit 1
	@mv _build/out/$(basename $*).native $@

out/%.ml.byte : out/%.ml
	@ocamlbuild out/$(basename $*).byte || exit 1
	@mv _build/out/$(basename $*).byte $@

out/%.bin.out : out/%.bin
	@./$< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.ml.native.out : out/%.ml.native
	@./$< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.ml.byte.out : out/%.ml.byte
	@./$< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.class.out : out/%.class
	@$(java) -classpath out $(basename $*) < tests/prog/$(basename $*).in > $@ || exit 1

out/%.ml.out : out/%.ml
	@ocaml $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.php.out : out/%.php
	@php $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.py.out : out/%.py
	@$(python) $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.sch.out : out/%.sch
	@gsc-script $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.rb.out : out/%.rb
	@ruby $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.exe.out : out/%.exe
	@mono $< < tests/prog/$(basename $*).in > $@ || exit 1

reset	= \033[0m
red	= \033[0;31m
green	= \033[0;32m
yellow	= \033[0;33m

TESTPROGS	=\
	@for i in $^; do \
	if diff "$$i" "$<" > /dev/null; then \
	echo "" > /dev/null; \
	else \
	echo "FAIL $^" > $@; \
	echo "$(red)FAIL $^$(reset)"; \
	return 1; \
	fi; \
	done; \
	cp $< $@ ;\

out/%.int.outs : out/%.ml.out out/%.py.out out/%.php.out out/%.rb.out #out/%.sch.out
	$(TESTPROGS)

out/%.bin.outs : out/%.cc.bin.out out/%.c.bin.out out/%.ml.native.out
	$(TESTPROGS)

out/%.managed.outs : out/%.class.out out/%.exe.out out/%.byte.out
	$(TESTPROGS)

out/%.startTest :
	@echo "$(yellow)TESTING $(basename $@)$(reset)"
	@touch $@

out/%.outs : out/%.bin.outs out/%.int.outs #out/%.managed.outs
	$(TESTPROGS)

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
testCompare : $(CMPTESTSDEPS)
	@echo "$(green)ALL TESTS OK$(reset)"

#never remove tmp files : powerfull for debug
FASTTESTSDEPS	:= $(addsuffix .fasttest, $(TESTS))
fastTestCmp : $(FASTTESTSDEPS)
	@echo "$(green)FAST TESTS OK$(reset)"

%.not_compile : %.startTest metalang
	@./metalang tests/not_compile/$(TESTBASENAME).metalang || exit 0
	@if [ -e $(TESTBASENAME).ml ]; then exit 1; fi
	@echo "$(green)OK $(TESTBASENAME)$(reset)"
	@touch $@

TESTSNOTCOMPILE	:= $(addprefix out/, $(addsuffix .not_compile, $(TESTSNOTCOMPILEFILES)))
testNotCompile : $(TESTSNOTCOMPILE)
	@echo "$(green)NOT COMPILE TESTS OK$(reset)"


doc :
	@ocamlbuild metalang.docdir/index.html

.PHONY: clean
clean :
	@rm -rf out 2> /dev/null || true
	@ocamlbuild -clean
	@echo "OK"
