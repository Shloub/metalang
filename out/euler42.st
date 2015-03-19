Object subclass: euler42 [
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
   is_triangular: n  [|a|
    "
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   "
    a := (((n * 2)) sqrt floor).
    ^ ((a * (a + 1)) = (n * 2))
  ]
  
  score [|sum len c|
    self skip.
    len := self read_int.
    self skip.
    sum := 0.
    (1 to: len) do: [:i|
      c := self read_char.
      sum :=  (sum + ((((c) asciiValue) - (($A) asciiValue)) + 1)).
      "		print c print "" "" print sum print "" "" "
    ].
    (self is_triangular: sum)
      ifTrue:[^ 1]
      ifFalse:[^ 0].
  ]
  
  main [
    |sum n|(1 to: 55) do: [:i|
             (self is_triangular: i)
               ifTrue:[
                      (i) display.
                      ' ' display.
               ].
    ].
    '
' display.
    sum := 0.
    n := self read_int.
    (1 to: n) do: [:i|
      sum :=  (sum + (self score)).
    ].
    (sum) display.
    '
' display.
    ]
]
Eval [ (euler42 new) main. ]

