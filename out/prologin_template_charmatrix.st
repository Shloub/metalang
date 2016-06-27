Object subclass: prologin_template_charmatrix [
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
   programme_candidat: tableau taille_x: taille_x taille_y: taille_y [|out0|
    out0 := 0.
    (0 to: (taille_y - 1)) do: [:i|
      (0 to: (taille_x - 1)) do: [:j|
        out0 := out0 + ((((tableau at: (i + 1)) at: (j + 1)) asciiValue) * (i + (j * 2))).
        ((tableau at: (i + 1)) at: (j + 1)) display.
      ].
      '--
' display.
    ].
    ^ out0
  ]
  
  main [
    |taille_y taille_x tableau c a|taille_x := self read_int.
    self skip.
    taille_y := self read_int.
    self skip.
    a := Array new: taille_y.
    (0 to: (taille_y - 1)) do: [:b|
      c := Array new: taille_x.
      (0 to: (taille_x - 1)) do: [:d| c at: (d + 1) put: self read_char.].
      self skip.
      a at: (b + 1) put: c.
    ].
    tableau := a.
    (self programme_candidat: tableau taille_x: taille_x taille_y: taille_y) display.
    '
' display.
    ]
]
Eval [ (prologin_template_charmatrix new) main. ]

