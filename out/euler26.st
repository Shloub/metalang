Object subclass: euler26 [
   periode: restes c: c d: d b: b [|reste len chiffre a|
    len := c.
    a := d.
    [a ~= 0] whileTrue:[
      chiffre := a quo: b.
      reste := a rem: b.
      (0 to: (len - 1)) do: [:i| ((restes at: (i + 1)) = reste)
        ifTrue:[^ len - i].].
      restes at: (len + 1) put: reste.
      len := len + 1.
      a := reste * 10.
    ].
    ^ 0
  ]
  main [
    |t p mi m|t := Array new: 1000.
    (0 to: 999) do: [:j| t at: (j + 1) put: 0.].
    m := 0.
    mi := 0.
    (1 to: 1000) do: [:i|
      p := (self periode: t c: 0 d: 1 b: i).
      (p > m)
      ifTrue:[
        mi := i.
        m := p.
      ].
    ].
    mi display.
    '
' display.
    m display.
    '
' display.
    ]
]
Eval [ (euler26 new) main. ]

