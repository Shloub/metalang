Object subclass: euler14 [
   next0: n  [
    ((n rem: 2) = 0)
    ifTrue:[^ n quo: 2]
    ifFalse:[^ 3 * n + 1].
  ]
   find: n m: m [
    (n = 1)
    ifTrue:[^ 1]
    ifFalse:[(n >= 1000000)
      ifTrue:[^ 1 + (self find: (self next0: n) m: m)]
      ifFalse:[((m at: (n + 1)) ~= 0)
        ifTrue:[^ m at: (n + 1)]
        ifFalse:[
          m at: (n + 1) put: (1 + (self find: (self next0: n) m: m)).
          ^ m at: (n + 1)
        ].].].
  ]
  main [
    |n2 maxi max0 m|m := Array new: 1000000.
    (0 to: 999999) do: [:j| m at: (j + 1) put: 0.].
    max0 := 0.
    maxi := 0.
    (1 to: 999) do: [:i|
      " normalement on met 999999 mais ça dépasse les int32... "
      n2 := (self find: i m: m).
      (n2 > max0)
      ifTrue:[
        max0 := n2.
        maxi := i.
      ].
    ].
    max0 display.
    '
' display.
    maxi display.
    '
' display.
    ]
]
Eval [ (euler14 new) main. ]

