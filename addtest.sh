
echo "adding test $1"

for i in `echo ".c .c.bin.out .cc .cc.bin.out .cl .cl.out .class.out .cs .eval.out .exe.out .go .go.out .java .js .js.out .ml .ml.native.out .ml.out .pas .pas.bin.out .php .php.out .py .py.out .rb .rb.out"`; do
		git add "out/${1}$i"
done

git add tests/prog/$1.in
git add tests/prog/$1.metalang