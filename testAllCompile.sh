#!/bin/bash
echo "Tests qui doivent compiler"
ocamlbuild Main/main.byte  || exit 1
for i in `ls tests/compile/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.byte "$i" || exit 1
    gcc -c "$test.c" || exit 1
    rm "$test.o"
    #ocamlbuild "$test.cmx"
done