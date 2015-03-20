Object subclass: euler24 [
   fact: n  [|prod|
    prod := 1.
    (2 to: n) do: [:i|
      prod :=  (prod * i).
    ].
    ^ prod
  ]
  
   show: lim a: a [|t pris nth nchiffre n|
    nth := a.
    t := Array new: lim.
    (0 to: (lim - 1)) do: [:i|
      t at: (i + 1) put:  i.
    ].
    pris := Array new: lim.
    (0 to: (lim - 1)) do: [:j|
      pris at: (j + 1) put:  false.
    ].
    (1 to: (lim - 1)) do: [:k|
      n := (self fact: (lim - k)).
      nchiffre := (nth quo: n).
      nth :=  (nth rem: n).
      (0 to: (lim - 1)) do: [:l|
        (((pris at: (l + 1))) not)
          ifTrue:[
                 (nchiffre = 0)
                   ifTrue:[
                          (l) display.
                          pris at: (l + 1) put:  true.
                   ].
                 nchiffre :=  (nchiffre - 1).
          ].
      ].
    ].
    (0 to: (lim - 1)) do: [:m|
      (((pris at: (m + 1))) not)
        ifTrue:[(m) display.].
    ].
    '
' display.
  ]
  
  main [
    (self show: 10 a: 999999).
    ]
]
Eval [ (euler24 new) main. ]

