Object subclass: carre [
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
   min2_: a b: b [
    (a < b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
  main [
    |y x tab e|x := self read_int.
    self skip.
    y := self read_int.
    self skip.
    tab := Array new: y.
    (0 to: (y - 1)) do: [:d|
      e := Array new: x.
      (0 to: (x - 1)) do: [:f|
        e at: (f + 1) put: self read_int.
        self skip.
      ].
      tab at: (d + 1) put:  e.
    ].
    (1 to: (x - 1)) do: [:ix|
      (1 to: (y - 1)) do: [:iy|
        (((tab at: (iy + 1)) at: (ix + 1)) = 1)
          ifTrue:[(tab at: (iy + 1)) at: (ix + 1) put:  ((self min2_: (self min2_: ((tab at: (iy + 1)) at: ((ix - 1) + 1)) b: ((tab at: ((iy - 1) + 1)) at: (ix + 1))) b: ((tab at: ((iy - 1) + 1)) at: ((ix - 1) + 1))) + 1).].
      ].
    ].
    (0 to: (y - 1)) do: [:jy|
      (0 to: (x - 1)) do: [:jx|
        (((tab at: (jy + 1)) at: (jx + 1))) display.
        ' ' display.
      ].
      '
' display.
    ].
    ]
]
Eval [ (carre new) main. ]

