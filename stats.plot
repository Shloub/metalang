
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1932 (38357)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:18.13]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (38357)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [18.13:37.10]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2104 (38357)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [37.10:56.84]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2118 (38357)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [56.84:76.71]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2199 (38357)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [76.71:97.34]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2273 (38357)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [97.34:118.67]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (38357)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [118.67:141.03]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2426 (38357)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [141.03:163.79]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2485 (38357)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [163.79:187.11]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (38357)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [187.11:210.72]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2529 (38357)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [210.72:234.45]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2724 (38357)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [234.45:260.01]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3116 (38357)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [260.01:289.25]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3372 (38357)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [289.25:320.89]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 4158 (38357)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [320.89:359.91]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:2:2 with labels center offset 0,-3  rotate by 90 notitle

