Object subclass: aaa_07triplet [
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
    |l c b a|(1 to: 3) do: [:i|
               a := self read_int.
               self skip.
               b := self read_int.
               self skip.
               c := self read_int.
               self skip.
               'a = ' display.
               a display.
               ' b = ' display.
               b display.
               'c =' display.
               c display.
               '
' display.
    ].
    l := Array new: 10.
    (0 to: (10 - 1)) do: [:d|
      l at: (d + 1) put: self read_int.
      self skip.
    ].
    (0 to: 9) do: [:j|
      (l at: (j + 1)) display.
      '
' display.
    ].
    ]
]
Eval [ (aaa_07triplet new) main. ]

