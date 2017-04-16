struct
  cell% field ->a
  cell% field ->b
  cell% field ->c
  cell% field ->d
  cell% field ->e
  cell% field ->f
  cell% field ->g
  cell% field ->h
end-struct foo%


: default0 { a b c d e f }
  0 exit
;


: aa { b }
  
;

: main
  S\" ___\n" TYPE
  ;
main
BYE

