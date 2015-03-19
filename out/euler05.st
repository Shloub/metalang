Object subclass: euler05 [
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
   max2_: a b: b [
    (a > b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
   primesfactors: c  [|tab n d|
    n := c.
    tab := Array new: (n + 1).
    (0 to: ((n + 1) - 1)) do: [:i|
      tab at: (i + 1) put:  0.
    ].
    d := 2.
    [(((n ~= 1)) ifTrue:[((d * d) <= n)] ifFalse: [false])] whileTrue:
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
    (0 to: ((lim + 1) - 1)) do: [:m|
      o at: (m + 1) put:  0.
    ].
    (1 to: lim) do: [:i|
      t := (self primesfactors: i).
      (1 to: i) do: [:j|
        o at: (j + 1) put:  (self max2_: (o at: (j + 1)) b: (t at: (j + 1))).
      ].
    ].
    product := 1.
    (1 to: lim) do: [:k|
      (1 to: (o at: (k + 1))) do: [:l|
        product :=  (product * k).
      ].
    ].
    (product) display.
    '
' display.
    ]
]
Eval [ (euler05 new) main. ]

