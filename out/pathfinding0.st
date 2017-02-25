Object subclass: pathfinding0 [
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
   pathfind_aux: cache tab: tab x: x y: y posX: posX posY: posY [|val4 val3 val2 val1 out0|
    ((posX = (x - 1)) and: [posY = (y - 1)])
    ifTrue:[^ 0]
    ifFalse:[((((posX < 0) or: [posY < 0]) or: [posX >= x]) or: [posY >= y])
      ifTrue:[^ x * y * 10]
      ifFalse:[(((tab at: (posY + 1)) at: (posX + 1)) = $#)
        ifTrue:[^ x * y * 10]
        ifFalse:[(((cache at: (posY + 1)) at: (posX + 1)) ~= (0 - 1))
          ifTrue:[^ (cache at: (posY + 1)) at: (posX + 1)]
          ifFalse:[
            (cache at: (posY + 1)) at: (posX + 1) put: (x * y * 10).
            val1 := (self pathfind_aux: cache tab: tab x: x y: y posX: (posX + 1) posY: posY).
            val2 := (self pathfind_aux: cache tab: tab x: x y: y posX: (posX - 1) posY: posY).
            val3 := (self pathfind_aux: cache tab: tab x: x y: y posX: posX posY: (posY - 1)).
            val4 := (self pathfind_aux: cache tab: tab x: x y: y posX: posX posY: (posY + 1)).
            out0 := 1 + ((((((val1) min: (val2))) min: (val3))) min: (val4)).
            (cache at: (posY + 1)) at: (posX + 1) put: out0.
            ^ out0
          ].].].].
  ]
   pathfind: tab x: x y: y [|tmp cache|
    cache := Array new: y.
    (0 to: (y - 1)) do: [:i|
      tmp := Array new: x.
      (0 to: (x - 1)) do: [:j|
        ((tab at: (i + 1)) at: (j + 1)) display.
        tmp at: (j + 1) put: (0 - 1).
      ].
      '
' display.
      cache at: (i + 1) put: tmp.
    ].
    ^ (self pathfind_aux: cache tab: tab x: x y: y posX: 0 posY: 0)
  ]
  main [
    |y x tab result g e|x := self read_int.
    self skip.
    y := self read_int.
    self skip.
    x display.
    ' ' display.
    y display.
    '
' display.
    e := Array new: y.
    (0 to: (y - 1)) do: [:f|
      g := Array new: x.
      (0 to: (x - 1)) do: [:h| g at: (h + 1) put: self read_char.].
      self skip.
      e at: (f + 1) put: g.
    ].
    tab := e.
    result := (self pathfind: tab x: x y: y).
    result display.
    ]
]
Eval [ (pathfinding0 new) main. ]

