echo "adding test $1"

for i in `echo ".cpp .cpp.bin.out .metalang .adb .adb.bin.out .pl .pl.out .rkt.out .rkt .fun.ml.out .fun.ml .c .c.bin.out .cc .cc.bin.out .cl .cl.out .class.out .cs .eval.out .exe.out .go .go.out .java .js .js.out .ml .ml.native.out .ml.out .pas .pas.bin.out .php .php.out .py .py.out .rb .rb.out .m .m.bin.out .hs .hs.exe.out .fun.ml.native.out .vb .exeVB.out .lua .lua.out .scala .scala.out .st .st.out .fs .fs.out .groovy .groovy.out .fsscript .fsscript.exe.out"`; do
		git add "out/${1}$i" || echo "fail out/${1}$i"
done

git add tests/prog/$1.in
git add tests/prog/$1.metalang
