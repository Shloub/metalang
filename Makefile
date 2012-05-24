
TESTSFILES	:= $(filter %.metalang, $(shell ls tests/prog/))
TESTS		:= $(addprefix out/, $(basename $(TESTSFILES)))
TESTSDEPS	:= $(addsuffix .test, $(TESTS))

TMPFILES	:=\
	$(addsuffix .c, $(TESTS)) \
	$(addsuffix .c.bin, $(TESTS)) \
	$(addsuffix .c.bin.out, $(TESTS)) \
	$(addsuffix .ml, $(TESTS)) \
	$(addsuffix .ml.out, $(TESTS)) \
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
	$(addsuffix .cc, $(TESTS)) \
	$(addsuffix .cc.bin, $(TESTS)) \
	$(addsuffix .cc.bin.out, $(TESTS)) \
	$(addsuffix .bin.outs, $(TESTS)) \
	$(addsuffix .int.outs, $(TESTS)) \
	$(addsuffix .managed.outs, $(TESTS)) \
	$(addsuffix .outs, $(TESTS))

.SECONDARY: $(TMPFILES)

GEN	= \
	@./metalang $< || exit 1

.PHONY: metalang
metalang : main.byte
	@mv main.byte metalang
main.byte :
	@ocamlbuild -lflag -g -cflag -g Main/main.byte

out :
	@mkdir out

out/%.c out/%.cc out/%.php out/%.py out/%.ml out/%.java out/%.cs: tests/prog/%.metalang metalang out
	$(GEN)
	@for f in `ls $(notdir $*).*`; do mv $$f out/$$f ; done

out/%.c.bin : out/%.c
	@gcc $< -o $@ || exit 1

out/%.cc.bin : out/%.cc
	@g++ $< -o $@ || exit 1

out/%.class : out/%.java
	@javac $< || exit 1

out/%.exe : out/%.cs
	@gmcs $< || exit 1

out/%.bin.out : out/%.bin
	@./$< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.class.out : out/%.class
	@java -classpath out $(basename $*) < tests/prog/$(basename $*).in > $@ || exit 1

out/%.ml.out : out/%.ml
	@ocaml $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.php.out : out/%.php
	@php $< < tests/prog/$(basename $*).in > $@ || exit 1

out/%.py.out : out/%.py
	@python3 $< < tests/prog/$(basename $*).in > $@ || exit 1

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

out/%.int.outs : out/%.ml.out out/%.py.out out/%.php.out
	$(TESTPROGS)

out/%.bin.outs : out/%.cc.bin.out out/%.c.bin.out
	$(TESTPROGS)

out/%.managed.outs : out/%.class.out out/%.exe.out
	$(TESTPROGS)

out/%.startTest :
	@echo "$(yellow)TESTING $(basename $@)$(reset)"
	@touch $@

out/%.outs : out/%.bin.outs out/%.int.outs #out/%.managed.outs
	$(TESTPROGS)

out/%.test : out/%.startTest out/%.outs
	@echo "$(green)OK $(basename $*)$(reset)";
	@touch $@

 #never remove tmp files : powerfull for debug
.PHONY: testCompare
testCompare : $(TESTSDEPS)
	@echo "$(green)ALL TESTS OK$(reset)"

.PHONY: clean
clean :
	@rm -rf out || true
	@ocamlbuild -clean

doc :
	@ocamlbuild metalang.docdir/index.html
