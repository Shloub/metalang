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
pas=$(st "out" "*.pas")
js=$(st "out" "*.js")
go=$(st "out" "*.go")
cl=$(st "out" "*.cl")
py=$(st "out" "*.py")
rb=$(st "out" "*.rb")
cs=$(st "out" "*.cs")
m=$(st "out" "*.m")
pl=$(st "out" "*.pl")
java=$(st "out" "*.java")
ada=$(st "out" "*.adb")
vb=$(st "out" "*.vb")
hs=$(st "out" "*.hs")
lua=$(st "out" "*.lua")
scala=$(st "out" "*.scala")
smalltalk=$(st "out" "*.st")

ml=$(( $ml - $funml ))

c=$(( $c * 1000 / $metalang))
cc=$(( $cc * 1000 / $metalang))
ml=$(( $ml * 1000 / $metalang))
funml=$(( $funml * 1000 / $metalang))
rkt=$(( $rkt * 1000 / $metalang))
php=$(( $php * 1000 / $metalang))
pas=$(( $pas * 1000 / $metalang))
js=$(( $js * 1000 / $metalang))
go=$(( $go * 1000 / $metalang))
cl=$(( $cl * 1000 / $metalang))
py=$(( $py * 1000 / $metalang))
rb=$(( $rb * 1000 / $metalang))
cs=$(( $cs * 1000 / $metalang))
m=$(( $m * 1000 / $metalang))
pl=$(( $pl * 1000 / $metalang))
vb=$(( $vb * 1000 / $metalang))
java=$(( $java * 1000 / $metalang))
ada=$(( $ada * 1000 / $metalang))
hs=$(( $hs * 1000 / $metalang))
lua=$(( $lua * 1000 / $metalang))
scala=$(( $scala * 1000 / $metalang))
smalltalk=$(( $smalltalk * 1000 / $metalang))

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

swap(){
    local line
    local i
    local word
    while read line; do
	for i in $(echo "$line" | rev); do
	    word=$(echo "$i" | rev)
	    echo -n "$word "
	done
	echo
    done
}

(echo "c $c
cc $cc
ml $ml
funml $funml
rkt $rkt
php $php
pas $pas
js $js
go $go
cl $cl
m $m
py $py
rb $rb
cs $cs
pl $pl
ada $ada
vb $vb
hs $hs
lua $lua
smalltalk $smalltalk
scala $scala
java $java" | swap | sort -n | swap ) > "$file"

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
set grid y
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
'' using 0:(\$2/2):2 with labels center offset 0,0  rotate by 90 notitle
"
}
filestatsplot > stats.plot

gnuplot stats.plot
