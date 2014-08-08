
set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 800, 300
set output 'size.png'
set key outside bottom horizontal autotitles nobox
set title "taille du projet" 
set grid
set timefmt "%Y-%m-%d.%H:%M:%S"
#set logscale y
set xdata time
plot \
     'countlines.dat' using 1:2 index 0 title "compiler" with lines,\
     'countlinesTest.dat' using 1:2 index 0 title "tests" with lines

set output 'langs.png'
set title "taille du projet" 

plot \
     'countlinesML.dat' using 1:2 index 0 title "ML" with lines,\
     'countlinesC.dat' using 1:2 index 0 title "C" with lines,\
     'countlinesCC.dat' using 1:2 index 0 title "CC" with lines,\
     'countlinesPY.dat' using 1:2 index 0 title "PY" with lines,\
     'countlinesPAS.dat' using 1:2 index 0 title "PAS" with lines,\
     'countlinesGO.dat' using 1:2 index 0 title "GO" with lines,\
     'countlinesPHP.dat' using 1:2 index 0 title "PHP" with lines,\
     'countlinesJAVA.dat' using 1:2 index 0 title "JAVA" with lines,\
     'countlinesCL.dat' using 1:2 index 0 title "CL" with lines
