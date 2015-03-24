Object subclass: euler09 [
  main [
    |cc c a2b2|"
	a + b + c = 1000 && a * a + b * b = c * c
	"
    (1 to: 1000) do: [:a|
      ((a + 1) to: 1000) do: [:b|
        c := (1000 - a - b).
        a2b2 := (a * a + (b * b)).
        cc := (c * c).
        (((cc = a2b2)) and: [(c > a)])
          ifTrue:[
                 (a) display.
                 '
' display.
                 (b) display.
                 '
' display.
                 (c) display.
                 '
' display.
                 (a * b * c) display.
                 '
' display.
          ].
      ].
    ].
    ]
]
Eval [ (euler09 new) main. ]

