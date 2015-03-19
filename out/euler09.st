Object subclass: euler09 [
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
  main [
    |cc c a2b2|"
	a + b + c = 1000 && a * a + b * b = c * c
	"
    (1 to: 1000) do: [:a|
      ((a + 1) to: 1000) do: [:b|
        c := ((1000 - a) - b).
        a2b2 := ((a * a) + (b * b)).
        cc := (c * c).
        (((cc = a2b2)) ifTrue:[(c > a)] ifFalse: [false])
          ifTrue:[
                 (a) display.
                 '
' display.
                 (b) display.
                 '
' display.
                 (c) display.
                 '
' display.
                 ((a * b) * c) display.
                 '
' display.
          ].
      ].
    ].
    ]
]
Eval [ (euler09 new) main. ]

