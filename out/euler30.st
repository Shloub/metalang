Object subclass: euler30 [
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
  main [
    |sum s r p|"
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
"
    p := Array new: 10.
    (0 to: (10 - 1)) do: [:i|
      p at: (i + 1) put:  ((((i * i) * i) * i) * i).
    ].
    sum := 0.
    (0 to: 9) do: [:a|
      (0 to: 9) do: [:b|
        (0 to: 9) do: [:c|
          (0 to: 9) do: [:d|
            (0 to: 9) do: [:e|
              (0 to: 9) do: [:f|
                s := ((((((p at: (a + 1)) + (p at: (b + 1))) + (p at: (c + 1))) + (p at: (d + 1))) + (p at: (e + 1))) + (p at: (f + 1))).
                r := (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000)).
                (((s = r)) ifTrue:[(r ~= 1)] ifFalse: [false])
                  ifTrue:[
                         (f) display.
                         (e) display.
                         (d) display.
                         (c) display.
                         (b) display.
                         (a) display.
                         ' ' display.
                         (r) display.
                         '
' display.
                         sum :=  (sum + r).
                  ].
              ].
            ].
          ].
        ].
      ].
    ].
    (sum) display.
    ]
]
Eval [ (euler30 new) main. ]

