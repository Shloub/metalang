Object subclass: euler07 [
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
   divisible: n t: t size: size [
    (0 to: (size - 1)) do: [:i|
      ((n rem: (t at: (i + 1))) = 0)
        ifTrue:[^ true].
    ].
    ^ false
  ]
  
   find: a t: t b: b nth: nth [|used n|
    n := a.
    used := b.
    [(used ~= nth)] whileTrue:
    [(self divisible: n t: t size: used)
      ifTrue:[n :=  (n + 1).]
      ifFalse:[
              t at: (used + 1) put:  n.
              n :=  (n + 1).
              used :=  (used + 1).
      ].].
    ^ (t at: ((used - 1) + 1))
  ]
  
  main [
    |t n|n := 10001.
    t := Array new: n.
    (0 to: (n - 1)) do: [:i|
      t at: (i + 1) put:  2.
    ].
    ((self find: 3 t: t b: 1 nth: n)) display.
    '
' display.
    ]
]
Eval [ (euler07 new) main. ]

