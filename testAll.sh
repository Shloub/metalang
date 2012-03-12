#!/bin/bash

ocamlbuild Main/main.native  || exit 1

for i in `ls tests/prog/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.native "$i"  || exit 1
    bash cmpAll.sh "$test" "tests/prog/$test.in"  || exit 1
done