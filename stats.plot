
set terminal pngcairo transparent size 600, 600
set output 'repartition.png'
set title "repartition des langages"
set style fill solid 0.25 noborder
set boxwidth 0.75
set grid y
set yrange [0:*]
set xtic rotate by -25 scale 0 font ",8"
# rb : 1925 (41220)

#set object 11 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [.0:16.81]
#set object 11 front lw 1.0 fillstyle solid 1.00 border lt -1

# ml : 2022 (41220)

#set object 12 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [16.81:34.46]
#set object 12 front lw 1.0 fillstyle solid 1.00 border lt -1

# py : 2100 (41220)

#set object 13 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [34.46:52.80]
#set object 13 front lw 1.0 fillstyle solid 1.00 border lt -1

# c : 2109 (41220)

#set object 14 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [52.80:71.21]
#set object 14 front lw 1.0 fillstyle solid 1.00 border lt -1

# php : 2195 (41220)

#set object 15 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [71.21:90.38]
#set object 15 front lw 1.0 fillstyle solid 1.00 border lt -1

# m : 2260 (41220)

#set object 16 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [90.38:110.11]
#set object 16 front lw 1.0 fillstyle solid 1.00 border lt -1

# go : 2383 (41220)

#set object 17 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [110.11:130.92]
#set object 17 front lw 1.0 fillstyle solid 1.00 border lt -1

# java : 2413 (41220)

#set object 18 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [130.92:151.99]
#set object 18 front lw 1.0 fillstyle solid 1.00 border lt -1

# cc : 2473 (41220)

#set object 19 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [151.99:173.58]
#set object 19 front lw 1.0 fillstyle solid 1.00 border lt -1

# js : 2500 (41220)

#set object 20 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [173.58:195.41]
#set object 20 front lw 1.0 fillstyle solid 1.00 border lt -1

# cs : 2516 (41220)

#set object 21 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [195.41:217.38]
#set object 21 front lw 1.0 fillstyle solid 1.00 border lt -1

# funml : 2657 (41220)

#set object 22 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [217.38:240.58]
#set object 22 front lw 1.0 fillstyle solid 1.00 border lt -1

# pas : 3080 (41220)

#set object 23 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [240.58:267.47]
#set object 23 front lw 1.0 fillstyle solid 1.00 border lt -1

# pl : 3088 (41220)

#set object 24 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [267.47:294.43]
#set object 24 front lw 1.0 fillstyle solid 1.00 border lt -1

# cl : 3346 (41220)

#set object 25 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [294.43:323.65]
#set object 25 front lw 1.0 fillstyle solid 1.00 border lt -1

# rkt : 4153 (41220)

#set object 26 circle center screen 0.5, 0.5, 0 size screen 0.4 arc [323.65:359.92]
#set object 26 front lw 1.0 fillstyle solid 1.00 border lt -1


set size ratio -1 1,1
plot 'stats_repartition.dat' using 2:xtic(1) notitle with boxes,'' using 0:($2/2):2 with labels center offset 0,0  rotate by 90 notitle

