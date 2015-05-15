Object subclass: euler34 [
  main [
    |sum out0 num f|f := Array new: 10.
    (0 to: (10 - 1)) do: [:j|
      f at: (j + 1) put:  1.
    ].
    (1 to: 9) do: [:i|
      f at: (i + 1) put:  ((f at: (i + 1)) * (i * (f at: i))).
      (f at: (i + 1)) display.
      ' ' display.
    ].
    out0 := 0.
    '
' display.
    (0 to: 9) do: [:a|
      (0 to: 9) do: [:b|
        (0 to: 9) do: [:c|
          (0 to: 9) do: [:d|
            (0 to: 9) do: [:e|
              (0 to: 9) do: [:g|
                sum := (f at: (a + 1)) + (f at: (b + 1)) + (f at: (c + 1)) + (f at: (d + 1)) + (f at: (e + 1)) + (f at: (g + 1)).
                num := a * 10 + b * 10 + c * 10 + d * 10 + e * 10 + g.
                (a = 0)
                  ifTrue:[
                         sum :=  (sum - 1).
                         (b = 0)
                           ifTrue:[
                                  sum :=  (sum - 1).
                                  (c = 0)
                                    ifTrue:[
                                           sum :=  (sum - 1).
                                           (d = 0)
                                             ifTrue:[sum :=  (sum - 1).].
                                    ].
                           ].
                  ].
                (((sum = num) and: [sum ~= 1]) and: [sum ~= 2])
                  ifTrue:[
                         out0 :=  (out0 + num).
                         num display.
                         ' ' display.
                  ].
              ].
            ].
          ].
        ].
      ].
    ].
    '
' display.
    out0 display.
    '
' display.
    ]
]
Eval [ (euler34 new) main. ]

