Object subclass: toto [
  | foo bar blah |
  foo [ ^foo ]
  bar [ ^bar ]
  blah [ ^blah ]
  foo: a [ foo := a. ] 
  bar: a [ bar := a. ] 
  blah: a [ blah := a. ] 
]
Object subclass: affect [
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
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
"
  
   mktoto: v1  [|t|
    t := toto new.
    t foo: v1.
    t bar: v1.
    t blah: v1.
    ^ t
  ]
  
   mktoto2: v1  [|t|
    t := toto new.
    t foo: (v1 + 3).
    t bar: (v1 + 2).
    t blah: (v1 + 1).
    ^ t
  ]
  
   result: t_ t2_: t2_ [|t3 t2 t len cache2 cache1 cache0|
    t := t_.
    t2 := t2_.
    t3 := toto new.
    t3 foo: 0.
    t3 bar: 0.
    t3 blah: 0.
    t3 :=  t2.
    t :=  t2.
    t2 :=  t3.
    t blah:  ((t blah) + 1).
    len := 1.
    cache0 := Array new: len.
    (0 to: (len - 1)) do: [:i|
      cache0 at: (i + 1) put:  (0-(i)).
    ].
    cache1 := Array new: len.
    (0 to: (len - 1)) do: [:j|
      cache1 at: (j + 1) put:  j.
    ].
    cache2 := cache0.
    cache0 :=  cache1.
    cache2 :=  cache0.
    ^ ((t foo) + ((t blah) * (t bar)) + ((t bar) * (t foo)))
  ]
  
  main [
    |t2 t|t := (self mktoto: 4).
    t2 := (self mktoto: 5).
    t bar: self read_int.
    self skip.
    t blah: self read_int.
    self skip.
    t2 bar: self read_int.
    self skip.
    t2 blah: self read_int.
    ((self result: t t2_: t2)) display.
    ((t blah)) display.
    ]
]
Eval [ (affect new) main. ]

