Object subclass: aaa_missing [
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
  "
  Ce test a été généré par Metalang.
"
   result: len tab: tab [|tab2|
    tab2 := Array new: len.
    (0 to: (len - 1)) do: [:i| tab2 at: (i + 1) put: false.].
    (0 to: (len - 1)) do: [:i1|
      (tab at: (i1 + 1)) display.
      ' ' display.
      tab2 at: ((tab at: (i1 + 1)) + 1) put: true.
    ].
    '
' display.
    (0 to: (len - 1)) do: [:i2| ((tab2 at: (i2 + 1)) not)
      ifTrue:[^ i2].].
    ^ 0 - 1
  ]
  main [
    |tab len|len := self read_int.
    self skip.
    len display.
    '
' display.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:a| tab at: (a + 1) put: self read_int.
      self skip.].
    (self result: len tab: tab) display.
    '
' display.
    ]
]
Eval [ (aaa_missing new) main. ]

