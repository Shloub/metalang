
TESTSFILES	:= $(filter %.metalang, $(shell ls tests/prog/))
TESTS		:= $(basename $(TESTSFILES))
TESTSDEPS	:= $(addsuffix .test, $(TESTS))

TMPFILES	:=\
	$(addsuffix .c, $(TESTS)) \
	$(addsuffix .c.bin, $(TESTS)) \
	$(addsuffix .c.bin.out, $(TESTS)) \
	$(addsuffix .ml, $(TESTS)) \
	$(addsuffix .ml.out, $(TESTS)) \
	$(addsuffix .java, $(TESTS)) \
	$(addsuffix .java.out, $(TESTS)) \
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

TESTBASENAME	= `echo "$<" | cut -d . -f 1`
GEN	= \
	@./main.byte $< || exit 1

.PHONY: main.byte
main.byte :
	@ocamlbuild Main/main.byte

%.c %.cc %.php %.ml %.java %.cs: tests/prog/%.metalang main.byte
	$(GEN)

%.c.bin : %.c
	@gcc $< -o $@ || exit 1

%.cc.bin : %.cc
	@g++ $< -o $@ || exit 1

%.class : %.java
	@javac $< || exit 1

%.exe : %.cs
	@gmcs $< || exit 1

%.bin.out : %.bin
	@./$< < tests/prog/$(TESTBASENAME).in > $@ || exit 1

%.class.out : %.class
	@java $(TESTBASENAME) < tests/prog/$(TESTBASENAME).in > $@ || exit 1

%.ml.out : %.ml
	@ocaml $< < tests/prog/$(TESTBASENAME).in > $@ || exit 1

%.php.out : %.php
	@php $< < tests/prog/$(TESTBASENAME).in > $@ || exit 1

%.exe.out : %.exe
	@mono $< < tests/prog/$(TESTBASENAME).in > $@ || exit 1

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

%.int.outs : %.ml.out %.php.out
	$(TESTPROGS)

%.bin.outs : %.cc.bin.out %.c.bin.out
	$(TESTPROGS)

%.managed.outs : %.class.out %.exe.out
	$(TESTPROGS)

%.startTest :
	@echo "$(yellow)TESTING $(basename $@)$(reset)"
	@touch $@

%.outs : %.bin.outs %.int.outs %.managed.outs
	$(TESTPROGS)

%.test : %.startTest %.outs
	@echo "$(green)OK $(TESTBASENAME)$(reset)";
	@touch $@

 #never remove tmp files : powerfull for debug
.PHONY: testCompare
testCompare : $(TESTSDEPS)
	@echo "$(green)ALL TESTS OK$(reset)"

.PHONY: clean
clean :
	@rm $(TMPFILES) 2> /dev/null || true
	@echo "OK"
