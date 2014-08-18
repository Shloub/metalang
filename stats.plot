
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# c : 2118 (34370)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:22.18]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2485 (34370)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [22.18:48.20]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (34370)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [48.20:69.37]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 3019 (34370)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [69.37:100.99]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 4506 (34370)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [100.99:148.18]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2199 (34370)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [148.18:171.21]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 3288 (34370)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [171.21:205.64]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (34370)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [205.64:230.60]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3372 (34370)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [230.60:265.91]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2104 (34370)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [265.91:287.94]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# rb : 1932 (34370)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [287.94:308.17]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (34370)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [308.17:334.52]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2426 (34370)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [334.52:359.93]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:2:2 with labels center offset 0,-3  rotate by 90 notitle

