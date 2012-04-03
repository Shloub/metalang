#!/bin/bash

rme(){
    if [ -e "$1" ]; then rm "$1"; fi 
}

ocamlbuild Main/main.byte  || exit 1

for i in `ls tests/prog/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.byte "$i"  || exit 1
    bash cmpAll.sh "$test" "tests/prog/$test.in"  || exit 1
    rme "$test.tex"
    rme "$test.log"
    rme "$test.c"
    rme "$test.cc"
    rme "$test.java"
    rme "$test.ml"
    rme "$test.php"
    rme "$test.cs"
done