Object subclass: euler36 [
   palindrome2: pow2 n: n [|t nnum|
    t := Array new: 20.
    (0 to: (20 - 1)) do: [:i| t at: (i + 1) put: (((n quo: (pow2 at: (i + 1))) rem: 2) = 1).].
    nnum := 0.
    (1 to: 19) do: [:j| (t at: (j + 1))
      ifTrue:[nnum := j.].].
    (0 to: (nnum quo: 2)) do: [:k| ((t at: (k + 1)) ~= (t at: (nnum - k + 1)))
      ifTrue:[^ false].].
    ^ true
  ]
  
  main [
    |sum pow2 p num3 num2 num1 num0 a|p := 1.
    pow2 := Array new: 20.
    (0 to: (20 - 1)) do: [:i|
      p := p * 2.
      pow2 at: (i + 1) put: (p quo: 2).
    ].
    sum := 0.
    (1 to: 9) do: [:d|
      (self palindrome2: pow2 n: d)
      ifTrue:[
        d display.
        '
' display.
        sum := sum + d.
      ].
      (self palindrome2: pow2 n: (d * 10 + d))
      ifTrue:[
        (d * 10 + d) display.
        '
' display.
        sum := sum + (d * 10 + d).
      ].
    ].
    (0 to: 4) do: [:a0|
      a := a0 * 2 + 1.
      (0 to: 9) do: [:b|
        (0 to: 9) do: [:c|
          num0 := a * 100000 + (b * 10000) + (c * 1000) + (c * 100) + (b * 10) + a.
          (self palindrome2: pow2 n: num0)
          ifTrue:[
            num0 display.
            '
' display.
            sum := sum + num0.
          ].
          num1 := a * 10000 + (b * 1000) + (c * 100) + (b * 10) + a.
          (self palindrome2: pow2 n: num1)
          ifTrue:[
            num1 display.
            '
' display.
            sum := sum + num1.
          ].
        ].
        num2 := a * 100 + (b * 10) + a.
        (self palindrome2: pow2 n: num2)
        ifTrue:[
          num2 display.
          '
' display.
          sum := sum + num2.
        ].
        num3 := a * 1000 + (b * 100) + (b * 10) + a.
        (self palindrome2: pow2 n: num3)
        ifTrue:[
          num3 display.
          '
' display.
          sum := sum + num3.
        ].
      ].
    ].
    'sum=' display.
    sum display.
    '
' display.
    ]
]
Eval [ (euler36 new) main. ]

