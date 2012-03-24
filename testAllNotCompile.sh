#!/bin/bash
echo "Tests qui ne doivent pas compiler"
ocamlbuild Main/main.native  || exit 1
for i in `ls tests/not_compile/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.native "$i" && exit 1
done