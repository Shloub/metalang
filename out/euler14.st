Object subclass: euler14 [
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
   next0: n  [
    ((n rem: 2) = 0)
      ifTrue:[^ (n quo: 2)]
      ifFalse:[^ ((3 * n) + 1)].
  ]
  
   find: n m: m [
    (n = 1)
      ifTrue:[^ 1]
      ifFalse:[(n >= 1000000)
                ifTrue:[^ (1 + (self find: (self next0: n) m: m))]
                ifFalse:[((m at: (n + 1)) ~= 0)
                          ifTrue:[^ (m at: (n + 1))]
                          ifFalse:[
                                  m at: (n + 1) put:  (1 + (self find: (self next0: n) m: m)).
                                  ^ (m at: (n + 1))
                          ].].].
  ]
  
  main [
    |n2 maxi max0 m|m := Array new: 1000000.
    (0 to: (1000000 - 1)) do: [:j|
      m at: (j + 1) put:  0.
    ].
    max0 := 0.
    maxi := 0.
    (1 to: 999) do: [:i|
      " normalement on met 999999 mais ça dépasse les int32... "
      n2 := (self find: i m: m).
      (n2 > max0)
        ifTrue:[
               max0 :=  n2.
               maxi :=  i.
        ].
    ].
    (max0) display.
    '
' display.
    (maxi) display.
    '
' display.
    ]
]
Eval [ (euler14 new) main. ]

