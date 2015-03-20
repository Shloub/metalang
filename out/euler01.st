Object subclass: euler01 [
  main [
    |sum|sum := 0.
    (0 to: 999) do: [:i|
      ((((i rem: 3) = 0)) ifTrue:[true] ifFalse: [((i rem: 5) = 0)])
        ifTrue:[sum :=  (sum + i).].
    ].
    (sum) display.
    '
' display.
    ]
]
Eval [ (euler01 new) main. ]

