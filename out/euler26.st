Object subclass: euler26 [
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
   periode: restes c: c d: d b: b [|reste len chiffre a|
    len := c.
    a := d.
    [(a ~= 0)] whileTrue:
    [
    chiffre := (a quo: b).
    reste := (a rem: b).
    (0 to: (len - 1)) do: [:i|
      ((restes at: (i + 1)) = reste)
        ifTrue:[^ (len - i)].
    ].
    restes at: (len + 1) put:  reste.
    len :=  (len + 1).
    a :=  (reste * 10).
    ].
    ^ 0
  ]
  
  main [
    |t p mi m|t := Array new: 1000.
    (0 to: (1000 - 1)) do: [:j|
      t at: (j + 1) put:  0.
    ].
    m := 0.
    mi := 0.
    (1 to: 1000) do: [:i|
      p := (self periode: t c: 0 d: 1 b: i).
      (p > m)
        ifTrue:[
               mi :=  i.
               m :=  p.
        ].
    ].
    (mi) display.
    '
' display.
    (m) display.
    '
' display.
    ]
]
Eval [ (euler26 new) main. ]

