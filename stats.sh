# todo temps de compilations
# todo temps d'executions

st(){
    find out -name "$1" -exec cat {} \; | tr -d ' ' | wc -c
}

c=$(st "*.c")
cc=$(st "*.cc")
ml=$(st "*.ml")
php=$(st "*.php")
js=$(st "*.js")
go=$(st "*.go")
cl=$(st "*.cl")
py=$(st "*.py")
rb=$(st "*.rb")
cs=$(st "*.cs")
java=$(st "*.java")

file="stats_repartition.dat"

makearcstring(){
local arc=`echo "$1" | rev`
local exarc=`echo "$2" | rev`

local arcint=$(echo ${arc:2} | rev )
local arcfloat=$(echo ${arc:0:2} | rev )
local exarcint=$(echo ${exarc:2} | rev )
local exarcfloat=$(echo ${exarc:0:2} | rev )
echo "[$exarcint.$exarcfloat:$arcint.$arcfloat]"
}

echo "c $c" > "$file"
echo "cc $cc" >> "$file"
echo "ml $ml" >> "$file"
echo "php $php" >> "$file"
echo "js $js" >> "$file"
echo "go $go" >> "$file"
echo "cl $cl" >> "$file"
echo "py $py" >> "$file"
echo "rb $rb" >> "$file"
echo "cs $cs" >> "$file"
echo "java $java" >> "$file"
filestatsplot(){
    IFS='
'
    sum=0
    for i in `cat "$file"`; do
	lng=`echo "$i" | cut -d ' ' -f 1`
	size=`echo "$i" | cut -d ' ' -f 2`
	sum=$(( $sum + $size ))
    done
    position="center screen 0.5, 0.5"
    echo "
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title \"repartition des langages\"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
set xtic rotate by 90 scale 0 font \",8\""
    exarc=0
    n=10
# lignes commentées pour la création d'un camembert
    for i in `cat "$file"`; do
	n=$(($n + 1))
	lng=`echo "$i" | cut -d ' ' -f 1`
	size=`echo "$i" | cut -d ' ' -f 2`
	echo "# $lng : $size ($sum)"
	arc=$(( $exarc + 36000 * $size / $sum))
	arcstr=$(makearcstring $arc $exarc)
	echo "
#set object $n circle $position, 0 size screen 0.4 arc $arcstr
#set object $n front lw 1.0 fillstyle solid 1.00 border lt -1
"
	exarc=$arc
    done
echo "
set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,\
'' using 0:2:2 with labels center offset 0,-3  rotate by 90 notitle
"
}
filestatsplot > stats.plot

gnuplot stats.plot
