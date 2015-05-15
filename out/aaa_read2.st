Object subclass: aaa_read2 [
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
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
"
  main [
    |tmpc tab4 tab2 tab strlen len c|len := self read_int.
    self skip.
    len display.
    '=len
' display.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:a|
      tab at: (a + 1) put: self read_int.
      self skip.
    ].
    (0 to: (len - 1)) do: [:i|
      i display.
      '=>' display.
      (tab at: (i + 1)) display.
      ' ' display.
    ].
    '
' display.
    tab2 := Array new: len.
    (0 to: (len - 1)) do: [:b|
      tab2 at: (b + 1) put: self read_int.
      self skip.
    ].
    (0 to: (len - 1)) do: [:i_|
      i_ display.
      '==>' display.
      (tab2 at: (i_ + 1)) display.
      ' ' display.
    ].
    strlen := self read_int.
    self skip.
    strlen display.
    '=strlen
' display.
    tab4 := Array new: strlen.
    (0 to: (strlen - 1)) do: [:d|
      tab4 at: (d + 1) put: self read_char.
    ].
    self skip.
    (0 to: (strlen - 1)) do: [:i3|
      tmpc := tab4 at: (i3 + 1).
      c := ((tmpc) asciiValue).
      tmpc display.
      ':' display.
      c display.
      ' ' display.
      (tmpc ~= $ )
        ifTrue:[c :=  (((c - (($a) asciiValue) + 13) rem: 26) + (($a) asciiValue)).].
      tab4 at: (i3 + 1) put:  ((c) asCharacter).
    ].
    (0 to: (strlen - 1)) do: [:j|
      (tab4 at: (j + 1)) display.
    ].
    ]
]
Eval [ (aaa_read2 new) main. ]

