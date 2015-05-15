Object subclass: prologin_template_charline [
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
   programme_candidat: tableau taille: taille [|out0|
    out0 := 0.
    (0 to: (taille - 1)) do: [:i|
      out0 :=  (out0 + (((tableau at: (i + 1)) asciiValue) * i)).
      (tableau at: (i + 1)) display.
    ].
    '--
' display.
    ^ out0
  ]
  
  main [
    |taille tableau|taille := self read_int.
    self skip.
    tableau := Array new: taille.
    (0 to: (taille - 1)) do: [:a|
      tableau at: (a + 1) put: self read_char.
    ].
    self skip.
    (self programme_candidat: tableau taille: taille) display.
    '
' display.
    ]
]
Eval [ (prologin_template_charline new) main. ]

