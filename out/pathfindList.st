Object subclass: pathfindList [
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
   pathfind_aux: cache tab: tab len: len pos: pos [|posval out0 oneval|
    (pos >= (len - 1))
      ifTrue:[^ 0]
      ifFalse:[((cache at: (pos + 1)) ~= (0-(1)))
                ifTrue:[^ (cache at: (pos + 1))]
                ifFalse:[
                        cache at: (pos + 1) put:  (len * 2).
                        posval := (self pathfind_aux: cache tab: tab len: len pos: (tab at: (pos + 1))).
                        oneval := (self pathfind_aux: cache tab: tab len: len pos: (pos + 1)).
                        out0 := 0.
                        (posval < oneval)
                          ifTrue:[out0 :=  (1 + posval).]
                          ifFalse:[out0 :=  (1 + oneval).].
                        cache at: (pos + 1) put:  out0.
                        ^ out0
                ].].
  ]
  
   pathfind: tab len: len [|cache|
    cache := Array new: len.
    (0 to: (len - 1)) do: [:i|
      cache at: (i + 1) put:  (0-(1)).
    ].
    ^ (self pathfind_aux: cache tab: tab len: len pos: 0)
  ]
  
  main [
    |tmp tab result len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := 0.
      tmp := self read_int.
      self skip.
      tab at: (i + 1) put:  tmp.
    ].
    result := (self pathfind: tab len: len).
    (result) display.
    ]
]
Eval [ (pathfindList new) main. ]

