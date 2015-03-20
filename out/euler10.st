Object subclass: euler10 [
   eratostene: t max0: max0 [|sum j|
    sum := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               sum :=  (sum + i).
               ((max0 quo: i) > i)
                 ifTrue:[
                        j := (i * i).
                        [(((j < max0)) ifTrue:[(j > 0)] ifFalse: [false])] whileTrue:
                        [
                        t at: (j + 1) put:  0.
                        j :=  (j + i).
                        ].
                 ].
        ].
    ].
    ^ sum
  ]
  
  main [
    |t n|n := 100000.
    " normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages "
    t := Array new: n.
    (0 to: (n - 1)) do: [:i|
      t at: (i + 1) put:  i.
    ].
    t at: (1 + 1) put:  0.
    ((self eratostene: t max0: n)) display.
    '
' display.
    ]
]
Eval [ (euler10 new) main. ]

