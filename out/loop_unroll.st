Object subclass: loop_unroll [
  "
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
"
  main [
    |j|j := 0.
    j :=  0.
    (j) display.
    '
' display.
    j :=  1.
    (j) display.
    '
' display.
    j :=  2.
    (j) display.
    '
' display.
    j :=  3.
    (j) display.
    '
' display.
    j :=  4.
    (j) display.
    '
' display.
    ]
]
Eval [ (loop_unroll new) main. ]

