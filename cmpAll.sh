#!/bin/bash

echo "\nC"
gcc $1.c
cat $2 | ./a.out
echo "\nC++"
g++ $1.cc
cat $2 | ./a.out
echo "\njava"
javac $1.java
cat $2 | java $1
echo "\nphp"
cat $2 | php $1.php
echo "\nocaml"
cat $2 | ocaml $1.ml
