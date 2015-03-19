Object subclass: euler10 [
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
   eratostene: t max0: max0 [|sum j|
    sum := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               sum :=  (sum + i).
               ((max0 quo: i) > i)
                 ifTrue:[
                        j := (i * i).
                        [(((j < max0)) ifTrue:[(j > 0)] ifFalse: [false])] whileTrue:
                        [
                        t at: (j + 1) put:  0.
                        j :=  (j + i).
                        ].
                 ].
        ].
    ].
    ^ sum
  ]
  
  main [
    |t n|n := 100000.
    " normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages "
    t := Array new: n.
    (0 to: (n - 1)) do: [:i|
      t at: (i + 1) put:  i.
    ].
    t at: (1 + 1) put:  0.
    ((self eratostene: t max0: n)) display.
    '
' display.
    ]
]
Eval [ (euler10 new) main. ]

