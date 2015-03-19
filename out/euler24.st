Object subclass: euler24 [
  |buffer|
  read_int [|o|
    ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
     o := 0.
    (buffer isNil) ifFalse:[
    (buffer =~ '^(-?\d+)' asRegex) ifMatched: [:match |
    o := match at: 1.
    buffer := buffer allButFirst:(o size).
    ].
    ^o asInteger. ]
  ]
  skip [
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    (buffer =~ '^(\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].
    ]
  ]
  read_char [|o|
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    o := buffer at: 1.
    buffer := buffer allButFirst:1.
    ^o.
    ]
  ]
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
    (self show: 10
    a: 999999).
    ]
]
Eval [ (euler24 new) main. ]

