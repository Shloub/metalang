Object subclass: aaa_read1 [
  |buffer|
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
  main [
    |str|str := Array new: 12.
    (0 to: 11) do: [:a| str at: (a + 1) put: self read_char.].
    self skip.
    (0 to: 11) do: [:i| (str at: (i + 1)) display.].
    ]
]
Eval [ (aaa_read1 new) main. ]

