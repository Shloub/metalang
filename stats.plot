
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
set xtic rotate by 90 scale 0 font ",8"
# c : 105015 (1318492)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:28.67]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 115608 (1318492)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [28.67:60.23]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 99164 (1318492)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [60.23:87.30]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 108341 (1318492)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [87.30:116.88]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 157188 (1318492)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [116.88:159.79]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 117689 (1318492)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [159.79:191.92]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 172909 (1318492)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [191.92:239.13]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 103557 (1318492)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [239.13:267.40]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# rb : 95193 (1318492)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [267.40:293.39]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 124807 (1318492)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [293.39:327.46]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 119021 (1318492)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [327.46:359.95]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:2:2 with labels center offset 0,-3  rotate by 90 notitle

