Object subclass: prologin_template_intlist [
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
   programme_candidat: tableau taille: taille [|out0|
    out0 := 0.
    (0 to: (taille - 1)) do: [:i|
      out0 :=  (out0 + (tableau at: (i + 1))).
    ].
    ^ out0
  ]
  
  main [
    |taille tableau|taille := self read_int.
    self skip.
    tableau := Array new: taille.
    (0 to: (taille - 1)) do: [:a|
      tableau at: (a + 1) put: self read_int.
      self skip.
    ].
    (self programme_candidat: tableau taille: taille) display.
    '
' display.
    ]
]
Eval [ (prologin_template_intlist new) main. ]

