Object subclass: aaa_04loop [
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
   h: i  [|j|
    "  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end "
    j := (i - 2).
    [(j <= (i + 2))] whileTrue:
    [
    ((i rem: j) = 5)
      ifTrue:[^ true].
    j :=  (j + 1).
    ].
    ^ false
  ]
  
  main [
    |j i|j := 0.
    (0 to: 10) do: [:k|
      j :=  (j + k).
      (j) display.
      '
' display.
    ].
    i := 4.
    [(i < 10)] whileTrue:
    [
    (i) display.
    i :=  (i + 1).
    j :=  (j + i).
    ].
    (j) display.
    (i) display.
    'FIN TEST
' display.
    ]
]
Eval [ (aaa_04loop new) main. ]

