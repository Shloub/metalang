#!/bin/bash

echo "C"
gcc $1.c
cat $2 | ./a.out
echo "C++"
g++ $1.cc
cat $2 | ./a.out
echo "java"
javac $1.java
cat $2 | java $1
echo "php"
cat $2 | php $1.php
echo "ocaml"
cat $2 | ocaml $1.ml
