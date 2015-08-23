Object subclass: euler45 [
   triangle: n  [
    ((n rem: 2) = 0)
      ifTrue:[^ (n quo: 2) * (n + 1)]
      ifFalse:[^ n * ((n + 1) quo: 2)].
  ]
  
   penta: n  [
    ((n rem: 2) = 0)
      ifTrue:[^ (n quo: 2) * (3 * n - 1)]
      ifFalse:[^ ((3 * n - 1) quo: 2) * n].
  ]
  
   hexa: n  [
    ^ n * (2 * n - 1)
  ]
  
   findPenta2: n a: a b: b [|p c|
    (b = (a + 1))
      ifTrue:[^ ((self penta: a) = n) or: [(self penta: b) = n]].
    c := (a + b) quo: 2.
    p := (self penta: c).
    (p = n)
      ifTrue:[^ true]
      ifFalse:[(p < n)
                ifTrue:[^ (self findPenta2: n a: c b: b)]
                ifFalse:[^ (self findPenta2: n a: a b: c)].].
  ]
  
   findHexa2: n a: a b: b [|p c|
    (b = (a + 1))
      ifTrue:[^ ((self hexa: a) = n) or: [(self hexa: b) = n]].
    c := (a + b) quo: 2.
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
         ((self findPenta2: t a: (n quo: 5) b: n) and: [(self findHexa2: t a: (n quo: 5) b: ((n quo: 2) + 10))])
           ifTrue:[n display.
                  '
' display.
                  t display.
                  '
' display.].
    ].
    ]
]
Eval [ (euler45 new) main. ]

