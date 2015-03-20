Object subclass: euler02 [
  main [
    |sum c b a|a := 1.
    b := 2.
    sum := 0.
    [(a < 4000000)] whileTrue:
    [
    ((a rem: 2) = 0)
      ifTrue:[sum :=  (sum + a).].
    c := a.
    a :=  b.
    b :=  (b + c).
    ].
    (sum) display.
    '
' display.
    ]
]
Eval [ (euler02 new) main. ]

