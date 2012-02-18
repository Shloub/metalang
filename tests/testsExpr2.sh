#!/bin/bash

while true ; do

read test
out=`echo "$test" | ../testCalc.native`;
ref=`python -c "print ($test)"` 
if [ "$out" = "$ref" ]; then
    echo "=$out"
else
    echo "test $test FAIL : $out vs $ref"
fi
done