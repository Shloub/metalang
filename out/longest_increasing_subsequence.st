Object subclass: longest_increasing_subsequence [
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
   dichofind: len tab: tab tofind: tofind a: a b: b [|c|
    (a >= (b - 1))
    ifTrue:[^ a]
    ifFalse:[
      c := (a + b) quo: 2.
      ((tab at: (c + 1)) < tofind)
      ifTrue:[^ (self dichofind: len tab: tab tofind: tofind a: c b: b)]
      ifFalse:[^ (self dichofind: len tab: tab tofind: tofind a: a b: c)].
    ].
  ]
  
   process: len tab: tab [|size k|
    size := Array new: len.
    (0 to: (len - 1)) do: [:j| (j = 0)
      ifTrue:[size at: (j + 1) put: 0.]
      ifFalse:[size at: (j + 1) put: (len * 2).].].
    (0 to: (len - 1)) do: [:i|
      k := (self dichofind: len tab: size tofind: (tab at: (i + 1)) a: 0 b: (len - 1)).
      ((size at: (k + 2)) > (tab at: (i + 1)))
      ifTrue:[size at: (k + 2) put: (tab at: (i + 1)).].
    ].
    (0 to: (len - 1)) do: [:l| (size at: (l + 1)) display.
      ' ' display.].
    (0 to: (len - 1)) do: [:m|
      k := len - 1 - m.
      ((size at: (k + 1)) ~= (len * 2))
      ifTrue:[^ k].
    ].
    ^ 0
  ]
  main [
    |n len d|n := self read_int.
    self skip.
    (1 to: n) do: [:i|
      len := self read_int.
      self skip.
      d := Array new: len.
      (0 to: (len - 1)) do: [:e| d at: (e + 1) put: self read_int.
        self skip.].
      (self process: len tab: d) display.
      '
' display.
    ].
    ]
]
Eval [ (longest_increasing_subsequence new) main. ]

