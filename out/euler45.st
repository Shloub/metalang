Object subclass: euler45 [
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
   triangle: n  [
    ((n rem: 2) = 0)
      ifTrue:[^ ((n quo: 2) * (n + 1))]
      ifFalse:[^ (n * ((n + 1) quo: 2))].
  ]
  
   penta: n  [
    ((n rem: 2) = 0)
      ifTrue:[^ ((n quo: 2) * ((3 * n) - 1))]
      ifFalse:[^ ((((3 * n) - 1) quo: 2) * n)].
  ]
  
   hexa: n  [
    ^ (n * ((2 * n) - 1))
  ]
  
   findPenta2: n a: a b: b [|p c|
    (b = (a + 1))
      ifTrue:[^ ((((self penta: a) = n)) ifTrue:[true] ifFalse: [((self penta: b) = n)])].
    c := ((a + b) quo: 2).
    p := (self penta: c).
    (p = n)
      ifTrue:[^ true]
      ifFalse:[(p < n)
                ifTrue:[^ (self findPenta2: n a: c b: b)]
                ifFalse:[^ (self findPenta2: n a: a b: c)].].
  ]
  
   findHexa2: n a: a b: b [|p c|
    (b = (a + 1))
      ifTrue:[^ ((((self hexa: a) = n)) ifTrue:[true] ifFalse: [((self hexa: b) = n)])].
    c := ((a + b) quo: 2).
    p := (self hexa: c).
    (p = n)
      ifTrue:[^ true]
      ifFalse:[(p < n)
                ifTrue:[^ (self findHexa2: n a: c b: b)]
                ifFalse:[^ (self findHexa2: n a: a b: c)].].
  ]
  
  main [
    |t|(285 to: 55385) do: [:n|
         t := (self triangle: n).
         (((self findPenta2: t a: (n quo: 5) b: n)) ifTrue:[(self findHexa2: t a: (n quo: 5) b: ((n quo: 2) + 10))] ifFalse: [false])
           ifTrue:[
                  (n) display.
                  '
' display.
                  (t) display.
                  '
' display.
           ].
    ].
    ]
]
Eval [ (euler45 new) main. ]

