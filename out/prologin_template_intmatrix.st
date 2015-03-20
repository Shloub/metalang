Object subclass: prologin_template_intmatrix [
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
   programme_candidat: tableau x: x y: y [|out0|
    out0 := 0.
    (0 to: (y - 1)) do: [:i|
      (0 to: (x - 1)) do: [:j|
        out0 :=  (out0 + (((tableau at: (i + 1)) at: (j + 1)) * ((i * 2) + j))).
      ].
    ].
    ^ out0
  ]
  
  main [
    |taille_y taille_x tableau b|taille_x := self read_int.
    self skip.
    taille_y := self read_int.
    self skip.
    tableau := Array new: taille_y.
    (0 to: (taille_y - 1)) do: [:a|
      b := Array new: taille_x.
      (0 to: (taille_x - 1)) do: [:c|
        b at: (c + 1) put: self read_int.
        self skip.
      ].
      tableau at: (a + 1) put:  b.
    ].
    ((self programme_candidat: tableau x: taille_x y: taille_y)) display.
    '
' display.
    ]
]
Eval [ (prologin_template_intmatrix new) main. ]

