#!/bin/bash
echo "Tests qui ne doivent pas compiler"
ocamlbuild Main/main.byte  || exit 1
for i in `ls tests/not_compile/*.metalang`; do
    test=`basename "$i" | cut -d . -f 1`
    echo $test
    ./main.byte "$i" && exit 1
done