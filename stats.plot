
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set grid y
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1925 (40902)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:16.94]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (40902)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [16.94:34.73]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2100 (40902)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [34.73:53.21]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2109 (40902)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [53.21:71.77]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2195 (40902)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [71.77:91.08]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2260 (40902)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [91.08:110.97]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (40902)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [110.97:131.94]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2413 (40902)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [131.94:153.17]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2473 (40902)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [153.17:174.93]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2500 (40902)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [174.93:196.93]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (40902)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [196.93:219.07]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2564 (40902)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [219.07:241.63]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3080 (40902)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [241.63:268.73]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# pl : 3088 (40902)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [268.73:295.90]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3346 (40902)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [295.90:325.34]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 3928 (40902)

#set object 26 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [325.34:359.91]
#set object 26 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:($2/2):2 with labels center offset 0,0  rotate by 90 notitle

