
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set grid y
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1925 (40398)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:17.15]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (40398)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [17.15:35.16]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2100 (40398)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [35.16:53.87]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2109 (40398)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [53.87:72.66]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2195 (40398)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [72.66:92.22]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2260 (40398)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [92.22:112.35]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (40398)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [112.35:133.58]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2413 (40398)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [133.58:155.08]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2473 (40398)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [155.08:177.11]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2500 (40398)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [177.11:199.38]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (40398)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [199.38:221.80]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2564 (40398)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [221.80:244.64]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pl : 2584 (40398)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [244.64:267.66]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3080 (40398)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [267.66:295.10]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3346 (40398)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [295.10:324.91]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 3928 (40398)

#set object 26 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [324.91:359.91]
#set object 26 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:($2/2):2 with labels center offset 0,0  rotate by 90 notitle

