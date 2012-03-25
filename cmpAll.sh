#!/bin/bash

echo -e "\nC"
gcc $1.c || exit 1
cat $2 | ./a.out
rm a.out
echo -e "\nC++"
g++ $1.cc || exit 1
cat $2 | ./a.out
rm a.out 
echo -e "\njava"
javac $1.java || exit 1
cat $2 | java $1
rm "$1.class"
echo -e "\nphp"
cat $2 | php $1.php || exit 1
echo -e "\nocaml"
cat $2 | ocaml $1.ml || exit 1