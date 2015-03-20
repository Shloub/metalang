Object subclass: toto [
  | foo bar |
  foo [ ^foo ]
  bar [ ^bar ]
  foo: a [ foo := a. ] 
  bar: a [ bar := a. ] 
]
Object subclass: recordtest [
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
  
  main [
    |param|param := toto new.
    param foo: 0.
    param bar: 0.
    param bar: self read_int.
    self skip.
    param foo: self read_int.
    ((param bar) + ((param foo) * (param bar))) display.
    ]
]
Eval [ (recordtest new) main. ]

