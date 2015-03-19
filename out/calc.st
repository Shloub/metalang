Object subclass: calc [
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
  "
La suite de fibonaci
"
   fibo: a b: b i: i [|tmp out_ b2 a2|
    out_ := 0.
    a2 := a.
    b2 := b.
    (0 to: (i + 1)) do: [:j|
      (j) display.
      out_ :=  (out_ + a2).
      tmp := b2.
      b2 :=  (b2 + a2).
      a2 :=  tmp.
    ].
    ^ out_
  ]
  
  main [
    ((self fibo: 1 b: 2 i: 4)) display.
    ]
]
Eval [ (calc new) main. ]

