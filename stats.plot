
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set grid y
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1932 (37983)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:18.31]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (37983)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [18.31:37.47]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2104 (37983)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [37.47:57.41]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2118 (37983)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [57.41:77.48]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2199 (37983)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [77.48:98.32]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2273 (37983)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [98.32:119.86]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (37983)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [119.86:142.44]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2426 (37983)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [142.44:165.43]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2485 (37983)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [165.43:188.98]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (37983)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [188.98:212.82]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2529 (37983)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [212.82:236.78]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2580 (37983)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [236.78:261.23]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3116 (37983)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [261.23:290.76]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3372 (37983)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [290.76:322.71]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 3928 (37983)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [322.71:359.93]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:($2/2):2 with labels center offset 0,0  rotate by 90 notitle

