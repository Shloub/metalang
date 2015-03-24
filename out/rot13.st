Object subclass: rot13 [
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
  "
Ce test effectue un rot13 sur une chaine lue en entrée
"
  main [
    |tmpc tab4 strlen c|strlen := self read_int.
    self skip.
    tab4 := Array new: strlen.
    (0 to: (strlen - 1)) do: [:toto|
      tmpc := self read_char.
      c := ((tmpc) asciiValue).
      (tmpc ~= $ )
        ifTrue:[c :=  (((c - (($a) asciiValue) + 13) rem: 26) + (($a) asciiValue)).].
      tab4 at: (toto + 1) put:  ((c) asCharacter).
    ].
    (0 to: (strlen - 1)) do: [:j|
      ((tab4 at: (j + 1))) display.
    ].
    ]
]
Eval [ (rot13 new) main. ]

