Object subclass: intlist [
  | head tail |
  head [ ^head ]
  tail [ ^tail ]
  head: a [ head := a. ] 
  tail: a [ tail := a. ] 
]
Object subclass: linkedList [
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
   cons: list i: i [|out0|
    out0 := intlist new.
    out0 head: i.
    out0 tail: list.
    ^ out0
  ]
   is_empty: foo  [
    ^ true
  ]
   rev2: acc torev: torev [|acc2|
    (self is_empty: torev)
    ifTrue:[^ acc]
    ifFalse:[
      acc2 := intlist new.
      acc2 head: torev head.
      acc2 tail: acc.
      ^ (self rev2: acc torev: torev tail)
    ].
  ]
   rev: empty torev: torev [
    ^ (self rev2: empty torev: torev)
  ]
   test: empty  [|list i|
    list := empty.
    i := 0 - 1.
    [i ~= 0] whileTrue:[
      i := self read_int.
      (i ~= 0)
      ifTrue:[list := (self cons: list i: i).].
    ].
  ]
  main [
    
    ]
]
Eval [ (linkedList new) main. ]

