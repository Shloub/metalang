Object subclass: euler03 [
  main [
    |sqrtia maximum found b0 b a|maximum := 1.
    b0 := 2.
    a := 408464633.
    sqrtia := ((a) sqrt floor).
    [a ~= 1] whileTrue:
    [
    b := b0.
    found := false.
    [b <= sqrtia] whileTrue:
    [
    ((a rem: b) = 0)
      ifTrue:[
             a :=  (a quo: b).
             b0 :=  b.
             b :=  a.
             sqrtia :=  ((a) sqrt floor).
             found :=  true.
      ].
    b :=  (b + 1).
    ].
    (found not)
      ifTrue:[
             a display.
             '
' display.
             a :=  1.
      ].
    ].
    ]
]
Eval [ (euler03 new) main. ]

