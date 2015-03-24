Object subclass: cambriolage [
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
   nbPassePartout: n passepartout: passepartout m: m serrures: serrures [|pp max_recent_pp max_recent max_ancient_pp max_ancient|
    max_ancient := 0.
    max_recent := 0.
    (0 to: (m - 1)) do: [:i|
      (((((serrures at: (i + 1)) at: (0 + 1)) = (0-(1)))) and: [(((serrures at: (i + 1)) at: (1 + 1)) > max_ancient)])
        ifTrue:[max_ancient :=  ((serrures at: (i + 1)) at: (1 + 1)).].
      (((((serrures at: (i + 1)) at: (0 + 1)) = 1)) and: [(((serrures at: (i + 1)) at: (1 + 1)) > max_recent)])
        ifTrue:[max_recent :=  ((serrures at: (i + 1)) at: (1 + 1)).].
    ].
    max_ancient_pp := 0.
    max_recent_pp := 0.
    (0 to: (n - 1)) do: [:i|
      pp := (passepartout at: (i + 1)).
      ((((pp at: (0 + 1)) >= max_ancient)) and: [((pp at: (1 + 1)) >= max_recent)])
        ifTrue:[^ 1].
      max_ancient_pp :=  ((max_ancient_pp) max: ((pp at: (0 + 1)))).
      max_recent_pp :=  ((max_recent_pp) max: ((pp at: (1 + 1)))).
    ].
    (((max_ancient_pp >= max_ancient)) and: [(max_recent_pp >= max_recent)])
      ifTrue:[^ 2]
      ifFalse:[^ 0].
  ]
  
  main [
    |serrures passepartout out_ out1 out01 out0 n m|n := self read_int.
    self skip.
    passepartout := Array new: n.
    (0 to: (n - 1)) do: [:i|
      out0 := Array new: 2.
      (0 to: (2 - 1)) do: [:j|
        out01 := self read_int.
        self skip.
        out0 at: (j + 1) put:  out01.
      ].
      passepartout at: (i + 1) put:  out0.
    ].
    m := self read_int.
    self skip.
    serrures := Array new: m.
    (0 to: (m - 1)) do: [:k|
      out1 := Array new: 2.
      (0 to: (2 - 1)) do: [:l|
        out_ := self read_int.
        self skip.
        out1 at: (l + 1) put:  out_.
      ].
      serrures at: (k + 1) put:  out1.
    ].
    ((self nbPassePartout: n passepartout: passepartout m: m serrures: serrures)) display.
    ]
]
Eval [ (cambriolage new) main. ]

