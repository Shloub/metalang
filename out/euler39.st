Object subclass: euler39 [
  main [
    |t p j c2 c|t := Array new: 1001.
    (0 to: (1001 - 1)) do: [:i|
      t at: (i + 1) put:  0.
    ].
    (1 to: 1000) do: [:a|
      (1 to: 1000) do: [:b|
        c2 := ((a * a) + (b * b)).
        c := ((c2) sqrt floor).
        ((c * c) = c2)
          ifTrue:[
                 p := ((a + b) + c).
                 (p <= 1000)
                   ifTrue:[t at: (p + 1) put:  ((t at: (p + 1)) + 1).].
          ].
      ].
    ].
    j := 0.
    (1 to: 1000) do: [:k|
      ((t at: (k + 1)) > (t at: (j + 1)))
        ifTrue:[j :=  k.].
    ].
    (j) display.
    ]
]
Eval [ (euler39 new) main. ]

