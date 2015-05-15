Object subclass: euler08 [
  |buffer|
  read_char [|o|
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    o := buffer at: 1.
    buffer := buffer allButFirst:1.
    ^o.
    ]
  ]
  main [
    |nskipdiv max0 last index i f e d c|i := 1.
    last := Array new: 5.
    (0 to: (5 - 1)) do: [:j|
      c := self read_char.
      d := ((c) asciiValue) - (($0) asciiValue).
      i :=  (i * d).
      last at: (j + 1) put:  d.
    ].
    max0 := i.
    index := 0.
    nskipdiv := 0.
    (1 to: 995) do: [:k|
      e := self read_char.
      f := ((e) asciiValue) - (($0) asciiValue).
      (f = 0)
        ifTrue:[
               i :=  1.
               nskipdiv :=  4.
        ]
        ifFalse:[
                i :=  (i * f).
                (nskipdiv < 0)
                  ifTrue:[i :=  (i quo: (last at: (index + 1))).].
                nskipdiv :=  (nskipdiv - 1).
        ].
      last at: (index + 1) put:  f.
      index :=  ((index + 1) rem: 5).
      max0 :=  ((max0) max: (i)).
    ].
    max0 display.
    '
' display.
    ]
]
Eval [ (euler08 new) main. ]

