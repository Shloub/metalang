st(){
    find "$1" -name "$2" -exec cat {} \; | tr -d ' \n' | wc -c
}

metalang=$(st "tests/prog" "*.metalang")
c=$(st "out" "*.c")
cc=$(st "out" "*.cc")
ml=$(st "out" "*.ml")
funml=$(st "out" "*.fun.ml")
rkt=$(st "out" "*.rkt")
php=$(st "out" "*.php")
js=$(st "out" "*.js")
go=$(st "out" "*.go")
cl=$(st "out" "*.cl")
py=$(st "out" "*.py")
rb=$(st "out" "*.rb")
cs=$(st "out" "*.cs")
java=$(st "out" "*.java")

ml=$(( $ml - $funml ))

c=$(( $c * 1000 / $metalang))
cc=$(( $cc * 1000 / $metalang))
ml=$(( $ml * 1000 / $metalang))
funml=$(( $funml * 1000 / $metalang))
rkt=$(( $rkt * 1000 / $metalang))
php=$(( $php * 1000 / $metalang))
js=$(( $js * 1000 / $metalang))
go=$(( $go * 1000 / $metalang))
cl=$(( $cl * 1000 / $metalang))
py=$(( $py * 1000 / $metalang))
rb=$(( $rb * 1000 / $metalang))
cs=$(( $cs * 1000 / $metalang))
java=$(( $java * 1000 / $metalang))

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
echo "funml $funml" >> "$file"
echo "rkt $rkt" >> "$file"
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
set xtic rotate by -25 scale 0 font \",8\""
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
