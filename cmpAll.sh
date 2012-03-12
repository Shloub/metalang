#!/bin/bash

echo -e "\nC"
gcc $1.c
cat $2 | ./a.out
echo -e "\nC++"
g++ $1.cc
cat $2 | ./a.out
echo -e "\njava"
javac $1.java
cat $2 | java $1
echo -e "\nphp"
cat $2 | php $1.php
echo -e "\nocaml"
cat $2 | ocaml $1.ml
