Object subclass: toto [
  | foo bar blah |
  foo [ ^foo ]
  bar [ ^bar ]
  blah [ ^blah ]
  foo: a [ foo := a. ] 
  bar: a [ bar := a. ] 
  blah: a [ blah := a. ] 
]
Object subclass: record2 [
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
  
   mktoto: v1  [|t|
    t := toto new.
    t foo: v1.
    t bar: 0.
    t blah: 0.
    ^ t
  ]
  
   result: t  [
    t blah:  ((t blah) + 1).
    ^ (((t foo) + ((t blah) * (t bar))) + ((t bar) * (t foo)))
  ]
  
  main [
    |t|t := (self mktoto: 4).
    t bar: self read_int.
    self skip.
    t blah: self read_int.
    ((self result: t)) display.
    ]
]
Eval [ (record2 new) main. ]

