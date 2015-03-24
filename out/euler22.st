Object subclass: euler22 [
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
  score [|sum len c|
    self skip.
    len := self read_int.
    self skip.
    sum := 0.
    (1 to: len) do: [:i|
      c := self read_char.
      sum :=  (sum + (((c) asciiValue) - (($A) asciiValue) + 1)).
      "		print c print "" "" print sum print "" "" "
    ].
    ^ sum
  ]
  
  main [
    |sum n|sum := 0.
    n := self read_int.
    (1 to: n) do: [:i|
      sum :=  (sum + (i * (self score))).
    ].
    (sum) display.
    '
' display.
    ]
]
Eval [ (euler22 new) main. ]

