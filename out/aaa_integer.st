Object subclass: aaa_integer [
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
    |i|i := 0.
    i :=  (i - 1).
    (i) display.
    '
' display.
    i :=  (i + 55).
    (i) display.
    '
' display.
    i :=  (i * 13).
    (i) display.
    '
' display.
    i :=  (i quo: 2).
    (i) display.
    '
' display.
    i :=  (i + 1).
    (i) display.
    '
' display.
    i :=  (i quo: 3).
    (i) display.
    '
' display.
    i :=  (i - 1).
    (i) display.
    '
' display.
    "
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
"
    (117 quo: 17) display.
    '
' display.
    (117 quo: (0-(17))) display.
    '
' display.
    ((0-(117)) quo: 17) display.
    '
' display.
    ((0-(117)) quo: (0-(17))) display.
    '
' display.
    (117 rem: 17) display.
    '
' display.
    (117 rem: (0-(17))) display.
    '
' display.
    ((0-(117)) rem: 17) display.
    '
' display.
    ((0-(117)) rem: (0-(17))) display.
    '
' display.
    ]
]
Eval [ (aaa_integer new) main. ]

