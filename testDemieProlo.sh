
P0=`dirname "$BASH_SOURCE"`

rm $1*.out

echo "TESTING $1"
list="ls $1.*"
for i in $list; do
    make -f "$P0/proloMake" "$i.out"
done


for i in $list; do
    echo
    echo "$i"
    tail "$i.out" -n 3
done