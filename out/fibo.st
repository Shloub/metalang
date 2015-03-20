Object subclass: fibo [
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
  "
La suite de fibonaci
"
   fibo0: a b: b i: i [|tmp out0 b2 a2|
    out0 := 0.
    a2 := a.
    b2 := b.
    (0 to: (i + 1)) do: [:j|
      out0 :=  (out0 + a2).
      tmp := b2.
      b2 :=  (b2 + a2).
      a2 :=  tmp.
    ].
    ^ out0
  ]
  
  main [
    |i b a|a := 0.
    b := 0.
    i := 0.
    a := self read_int.
    self skip.
    b := self read_int.
    self skip.
    i := self read_int.
    ((self fibo0: a b: b i: i)) display.
    ]
]
Eval [ (fibo new) main. ]

