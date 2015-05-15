Object subclass: euler05 [
   primesfactors: c  [|tab n d|
    n := c.
    tab := Array new: (n + 1).
    (0 to: (n + 1 - 1)) do: [:i|
      tab at: (i + 1) put:  0.
    ].
    d := 2.
    [(n ~= 1) and: [d * d <= n]] whileTrue:
    [((n rem: d) = 0)
      ifTrue:[
             tab at: (d + 1) put:  ((tab at: (d + 1)) + 1).
             n :=  (n quo: d).
      ]
      ifFalse:[d :=  (d + 1).].].
    tab at: (n + 1) put:  ((tab at: (n + 1)) + 1).
    ^ tab
  ]
  
  main [
    |t product o lim|lim := 20.
    o := Array new: (lim + 1).
    (0 to: (lim + 1 - 1)) do: [:m|
      o at: (m + 1) put:  0.
    ].
    (1 to: lim) do: [:i|
      t := (self primesfactors: i).
      (1 to: i) do: [:j|
        o at: (j + 1) put:  ((o at: (j + 1)) max: (t at: (j + 1))).
      ].
    ].
    product := 1.
    (1 to: lim) do: [:k|
      (1 to: (o at: (k + 1))) do: [:l|
        product :=  (product * k).
      ].
    ].
    product display.
    '
' display.
    ]
]
Eval [ (euler05 new) main. ]

