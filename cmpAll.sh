#!/bin/bash

echo -e "C"
gcc $1.c || exit 1
cstdout=`./a.out < $2` || exit 1
rm a.out

if [ "1" = "$CXX" ]; then
    echo -e "C++"
    g++ $1.cc || exit 1
    ccstdout=`./a.out < $2` || exit 1
    rm a.out 
    if [ "$cstdout" != "$ccstdout" ]; then
	echo "<C>$cstdout</C><CC>$ccstdout</CC>"
	exit 1;
    fi
fi

if [ "1" = "$JAVA" ]; then
    echo -e "java"
    javac $1.java || exit 1
    javastdout=`java $1 < $2` || exit 1
    rm "$1.class"
    if [ "$cstdout" != "$javastdout" ]; then
	echo "<C>$cstdout</C><java>$javastdout</java>"
	exit 1;
    fi
fi

if [ "1" = "$PHP" ]; then
    echo -e "php"
    phpstdout=`php $1.php < $2` || exit 1
    if [ "$cstdout" != "$phpstdout" ]; then
	echo "<C>$cstdout</C><php>$phpstdout</php>"
	exit 1;
    fi
fi

if [ "1" = "$OCAML" ]; then
    echo -e "ocaml"
    mlstdout=`ocaml $1.ml < $2` || exit 1
    if [ "$cstdout" != "$mlstdout" ]; then
	echo "<C>$cstdout</C><ml>$mlstdout</ml>"
	exit 1;
    fi
fi

if [ "1" = "$TEX" ]; then
    echo -e "\nlatex"
    pdflatex "$1.tex" || exit 1
    rm "$1.pdf"
fi

#echo -e "\nC#"
#gmcs $1.cs
#cat $2 | mono $1.exe || exit 1

