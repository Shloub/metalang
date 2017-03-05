Object subclass: euler40 [
   exp0: a e: e [|o|
    o := 1.
    (1 to: e) do: [:i| o := o * a.].
    ^ o
  ]
  
   e: t b: b [|nombre n chiffre|
    n := b.
    (1 to: 8) do: [:i| (n >= ((t at: (i + 1)) * i))
      ifTrue:[n := n - ((t at: (i + 1)) * i).]
      ifFalse:[
        nombre := (self exp0: 10 e: (i - 1)) + (n quo: i).
        chiffre := i - 1 - (n rem: i).
        ^ (nombre quo: (self exp0: 10 e: chiffre)) rem: 10
      ].].
    ^ 0 - 1
  ]
  main [
    |v t puiss out0|t := Array new: 9.
    (0 to: 8) do: [:i| t at: (i + 1) put: ((self exp0: 10 e: i) - (self exp0: 10 e: (i - 1))).].
    (1 to: 8) do: [:i2| i2 display.
      ' => ' display.
      (t at: (i2 + 1)) display.
      '
' display.].
    (0 to: 80) do: [:j| (self e: t b: j) display.].
    '
' display.
    (1 to: 50) do: [:k| k display.].
    '
' display.
    (169 to: 220) do: [:j2| (self e: t b: j2) display.].
    '
' display.
    (90 to: 110) do: [:k2| k2 display.].
    '
' display.
    out0 := 1.
    (0 to: 6) do: [:l|
      puiss := (self exp0: 10 e: l).
      v := (self e: t b: (puiss - 1)).
      out0 := out0 * v.
      '10^' display.
      l display.
      '=' display.
      puiss display.
      ' v=' display.
      v display.
      '
' display.
    ].
    out0 display.
    '
' display.
    ]
]
Eval [ (euler40 new) main. ]

