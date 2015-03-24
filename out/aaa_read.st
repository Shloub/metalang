Object subclass: aaa_read [
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
    |tmpi2 tmpi1 tmpc tab4 tab2 tab strlen len c|len := self read_int.
    self skip.
    (len) display.
    '=len
' display.
    len :=  (len * 2).
    'len*2=' display.
    (len) display.
    '
' display.
    len :=  (len quo: 2).
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmpi1 := self read_int.
      self skip.
      (i) display.
      '=>' display.
      (tmpi1) display.
      ' ' display.
      tab at: (i + 1) put:  tmpi1.
    ].
    '
' display.
    tab2 := Array new: len.
    (0 to: (len - 1)) do: [:i_|
      tmpi2 := self read_int.
      self skip.
      (i_) display.
      '==>' display.
      (tmpi2) display.
      ' ' display.
      tab2 at: (i_ + 1) put:  tmpi2.
    ].
    strlen := self read_int.
    self skip.
    (strlen) display.
    '=strlen
' display.
    tab4 := Array new: strlen.
    (0 to: (strlen - 1)) do: [:toto|
      tmpc := self read_char.
      c := ((tmpc) asciiValue).
      (tmpc) display.
      ':' display.
      (c) display.
      ' ' display.
      (tmpc ~= $ )
        ifTrue:[c :=  (((c - (($a) asciiValue) + 13) rem: 26) + (($a) asciiValue)).].
      tab4 at: (toto + 1) put:  ((c) asCharacter).
    ].
    (0 to: (strlen - 1)) do: [:j|
      ((tab4 at: (j + 1))) display.
    ].
    ]
]
Eval [ (aaa_read new) main. ]

