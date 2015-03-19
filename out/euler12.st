Object subclass: euler12 [
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
   max2_: a b: b [
    (a > b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
   eratostene: t max0: max0 [|n j|
    n := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               j := (i * i).
               n :=  (n + 1).
               [(((j < max0)) ifTrue:[(j > 0)] ifFalse: [false])] whileTrue:
               [
               t at: (j + 1) put:  0.
               j :=  (j + i).
               ].
        ].
    ].
    ^ n
  ]
  
   fillPrimesFactors: t c: c primes: primes nprimes: nprimes [|n d|
    n := c.
    (0 to: (nprimes - 1)) do: [:i|
      d := (primes at: (i + 1)).
      [((n rem: d) = 0)] whileTrue:
      [
      t at: (d + 1) put:  ((t at: (d + 1)) + 1).
      n :=  (n quo: d).
      ].
      (n = 1)
        ifTrue:[^ (primes at: (i + 1))].
    ].
    ^ n
  ]
  
   find: ndiv2  [|primesFactors primes nprimes ndivs maximumprimes max0 l era|
    maximumprimes := 110.
    era := Array new: maximumprimes.
    (0 to: (maximumprimes - 1)) do: [:j|
      era at: (j + 1) put:  j.
    ].
    nprimes := (self eratostene: era max0: maximumprimes).
    primes := Array new: nprimes.
    (0 to: (nprimes - 1)) do: [:o|
      primes at: (o + 1) put:  0.
    ].
    l := 0.
    (2 to: (maximumprimes - 1)) do: [:k|
      ((era at: (k + 1)) = k)
        ifTrue:[
               primes at: (l + 1) put:  k.
               l :=  (l + 1).
        ].
    ].
    (1 to: 10000) do: [:n|
      primesFactors := Array new: (n + 2).
      (0 to: ((n + 2) - 1)) do: [:m|
        primesFactors at: (m + 1) put:  0.
      ].
      max0 := (self max2_: (self fillPrimesFactors: primesFactors c: n primes: primes nprimes: nprimes) b: (self fillPrimesFactors: primesFactors c: (n + 1) primes: primes nprimes: nprimes)).
      primesFactors at: (2 + 1) put:  ((primesFactors at: (2 + 1)) - 1).
      ndivs := 1.
      (0 to: max0) do: [:i|
        ((primesFactors at: (i + 1)) ~= 0)
          ifTrue:[ndivs :=  (ndivs * (1 + (primesFactors at: (i + 1)))).].
      ].
      (ndivs > ndiv2)
        ifTrue:[^ ((n * (n + 1)) quo: 2)].
      " print ""n="" print n print ""\t"" print (n * (n + 1) / 2 ) print "" "" print ndivs print ""\n"" "
    ].
    ^ 0
  ]
  
  main [
    ((self find: 500)) display.
    '
' display.
    ]
]
Eval [ (euler12 new) main. ]

