Object subclass: prologin_template_2charline [
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
   programme_candidat: tableau1 taille1: taille1 tableau2: tableau2 taille2: taille2 [|out0|
    out0 := 0.
    (0 to: (taille1 - 1)) do: [:i|
      out0 := out0 + (((tableau1 at: (i + 1)) asciiValue) * i).
      (tableau1 at: (i + 1)) display.
    ].
    '--
' display.
    (0 to: (taille2 - 1)) do: [:j|
      out0 := out0 + (((tableau2 at: (j + 1)) asciiValue) * (j * 100)).
      (tableau2 at: (j + 1)) display.
    ].
    '--
' display.
    ^ out0
  ]
  main [
    |taille2 taille1 tableau2 tableau1|taille1 := self read_int.
    self skip.
    tableau1 := Array new: taille1.
    (0 to: (taille1 - 1)) do: [:a| tableau1 at: (a + 1) put: self read_char.].
    self skip.
    taille2 := self read_int.
    self skip.
    tableau2 := Array new: taille2.
    (0 to: (taille2 - 1)) do: [:b| tableau2 at: (b + 1) put: self read_char.].
    self skip.
    (self programme_candidat: tableau1 taille1: taille1 tableau2: tableau2 taille2: taille2) display.
    '
' display.
    ]
]
Eval [ (prologin_template_2charline new) main. ]

