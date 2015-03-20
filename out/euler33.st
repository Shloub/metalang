Object subclass: euler33 [
   max2_: a b: b [
    (a > b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
   min2_: a b: b [
    (a < b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
   pgcd: a b: b [|reste d c|
    c := (self min2_: a b: b).
    d := (self max2_: a b: b).
    reste := (d rem: c).
    (reste = 0)
      ifTrue:[^ c]
      ifFalse:[^ (self pgcd: c b: reste)].
  ]
  
  main [
    |top p bottom b a|top := 1.
    bottom := 1.
    (1 to: 9) do: [:i|
      (1 to: 9) do: [:j|
        (1 to: 9) do: [:k|
          (((i ~= j)) ifTrue:[(j ~= k)] ifFalse: [false])
            ifTrue:[
                   a := ((i * 10) + j).
                   b := ((j * 10) + k).
                   ((a * k) = (i * b))
                     ifTrue:[
                            (a) display.
                            '/' display.
                            (b) display.
                            '
' display.
                            top :=  (top * a).
                            bottom :=  (bottom * b).
                     ].
            ].
        ].
      ].
    ].
    (top) display.
    '/' display.
    (bottom) display.
    '
' display.
    p := (self pgcd: top b: bottom).
    'pgcd=' display.
    (p) display.
    '
' display.
    (bottom quo: p) display.
    '
' display.
    ]
]
Eval [ (euler33 new) main. ]

