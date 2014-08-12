
set terminal pngcairo transparent size 600, 600
set output 'compilestats.png'
set title "temps de compilation"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
plot 'compilestats.dat' using 2:xtic(1) notitle with boxes,'' using 0:2:2 with labels center offset 0,-1 rotate by 90 notitle

