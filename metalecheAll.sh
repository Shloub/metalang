

for i in `find . -name "*.metalang"`; do
    dirname=`dirname $i`
    f=`basename $i`
    cd $dirname
    metalang $f
    cd ..
    metalang2prologin.sh
done
