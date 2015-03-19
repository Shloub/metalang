Object subclass: toto [
  | foo bar blah |
  foo [ ^foo ]
  bar [ ^bar ]
  blah [ ^blah ]
  foo: a [ foo := a. ] 
  bar: a [ bar := a. ] 
  blah: a [ blah := a. ] 
]
Object subclass: record3 [
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
  
   mktoto: v1  [|t|
    t := toto new.
    t foo: v1.
    t bar: 0.
    t blah: 0.
    ^ t
  ]
  
   result: t len: len [|out0|
    out0 := 0.
    (0 to: (len - 1)) do: [:j|
      (t at: (j + 1)) blah:  (((t at: (j + 1)) blah) + 1).
      out0 :=  (((out0 + ((t at: (j + 1)) foo)) + (((t at: (j + 1)) blah) * ((t at: (j + 1)) bar))) + (((t at: (j + 1)) bar) * ((t at: (j + 1)) foo))).
    ].
    ^ out0
  ]
  
  main [
    |titi t|t := Array new: 4.
    (0 to: (4 - 1)) do: [:i|
      t at: (i + 1) put:  (self mktoto: i).
    ].
    (t at: (0 + 1)) bar: self read_int.
    self skip.
    (t at: (1 + 1)) blah: self read_int.
    titi := (self result: t len: 4).
    (titi) display.
    (((t at: (2 + 1)) blah)) display.
    ]
]
Eval [ (record3 new) main. ]

