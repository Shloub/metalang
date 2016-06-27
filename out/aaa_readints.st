Object subclass: aaa_readints [
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
  main [
    |tab2 tab1 len c|len := self read_int.
    self skip.
    len display.
    '=len
' display.
    tab1 := Array new: len.
    (0 to: (len - 1)) do: [:a| tab1 at: (a + 1) put: self read_int.
      self skip.].
    (0 to: (len - 1)) do: [:i| i display.
      '=>' display.
      (tab1 at: (i + 1)) display.
      '
' display.].
    len := self read_int.
    self skip.
    tab2 := Array new: (len - 1).
    (0 to: (len - 1 - 1)) do: [:b|
      c := Array new: len.
      (0 to: (len - 1)) do: [:d| c at: (d + 1) put: self read_int.
        self skip.].
      tab2 at: (b + 1) put: c.
    ].
    (0 to: (len - 2)) do: [:i|
      (0 to: (len - 1)) do: [:j| ((tab2 at: (i + 1)) at: (j + 1)) display.
        ' ' display.].
      '
' display.
    ].
    ]
]
Eval [ (aaa_readints new) main. ]

