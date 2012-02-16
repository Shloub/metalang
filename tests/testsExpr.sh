#!/bin/bash

cd ..
ocamlbuild Parser/test.native
cd tests
for i in `ls tests_parse_expr/test*.in`; do
    test=`basename $i | cut -f 1 -d '.'`;
    out=`../test.native < $i`;
    ref=`cat tests_parse_expr/$test.ref`;
    if [ "$out" = "$ref" ]; then
	echo "test $test ok"
    else
	echo "test $test FAIL"
    fi
done