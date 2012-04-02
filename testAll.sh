#!/bin/bash

ocamlbuild Main/main.byte  || exit 1

for i in `ls tests/prog/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.byte "$i"  || exit 1
    bash cmpAll.sh "$test" "tests/prog/$test.in"  || exit 1
    rm "$test.tex"
    rm "$test.log"
    rm "$test.c"
    rm "$test.cc"
    rm "$test.java"
    rm "$test.ml"
    rm "$test.php"
    rm "$test.cs"
done