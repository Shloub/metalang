
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1932 (38295)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:18.16]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (38295)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [18.16:37.16]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2104 (38295)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [37.16:56.93]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2118 (38295)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [56.93:76.84]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2199 (38295)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [76.84:97.51]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2273 (38295)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [97.51:118.87]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (38295)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [118.87:141.27]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2426 (38295)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [141.27:164.07]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2485 (38295)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [164.07:187.43]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (38295)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [187.43:211.08]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2529 (38295)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [211.08:234.85]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2665 (38295)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [234.85:259.90]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3116 (38295)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [259.90:289.19]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3372 (38295)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [289.19:320.88]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 4155 (38295)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [320.88:359.93]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:2:2 with labels center offset 0,-3  rotate by 90 notitle

