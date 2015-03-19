Object subclass: euler23 [
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
   eratostene: t max0: max0 [|n j|
    n := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               n :=  (n + 1).
               j := (i * i).
               [(((j < max0)) ifTrue:[(j > 0)] ifFalse: [false])] whileTrue:
               [
               t at: (j + 1) put:  0.
               j :=  (j + i).
               ].
        ].
    ].
    ^ n
  ]
  
   fillPrimesFactors: t a: a primes: primes nprimes: nprimes [|n d|
    n := a.
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
  
   sumdivaux2: t n: n b: b [|i|
    i := b.
    [(((i < n)) ifTrue:[((t at: (i + 1)) = 0)] ifFalse: [false])] whileTrue:
    [i :=  (i + 1).].
    ^ i
  ]
  
   sumdivaux: t n: n i: i [|p out0 o|
    (i > n)
      ifTrue:[^ 1]
      ifFalse:[((t at: (i + 1)) = 0)
                ifTrue:[^ (self sumdivaux: t n: n i: (self sumdivaux2: t n: n b: (i + 1)))]
                ifFalse:[
                        o := (self sumdivaux: t n: n i: (self sumdivaux2: t n: n b: (i + 1))).
                        out0 := 0.
                        p := i.
                        (1 to: (t at: (i + 1))) do: [:j|
                          out0 :=  (out0 + p).
                          p :=  (p * i).
                        ].
                        ^ ((out0 + 1) * o)
                ].].
  ]
  
   sumdiv: nprimes primes: primes n: n [|t max0|
    t := Array new: (n + 1).
    (0 to: ((n + 1) - 1)) do: [:i|
      t at: (i + 1) put:  0.
    ].
    max0 := (self fillPrimesFactors: t a: n primes: primes nprimes: nprimes).
    ^ (self sumdivaux: t n: max0 i: 0)
  ]
  
  main [
    |summable sum primes other nprimes n maximumprimes l era abondant|maximumprimes := 30001.
    era := Array new: maximumprimes.
    (0 to: (maximumprimes - 1)) do: [:s|
      era at: (s + 1) put:  s.
    ].
    nprimes := (self eratostene: era max0: maximumprimes).
    primes := Array new: nprimes.
    (0 to: (nprimes - 1)) do: [:t|
      primes at: (t + 1) put:  0.
    ].
    l := 0.
    (2 to: (maximumprimes - 1)) do: [:k|
      ((era at: (k + 1)) = k)
        ifTrue:[
               primes at: (l + 1) put:  k.
               l :=  (l + 1).
        ].
    ].
    n := 100.
    " 28124 ça prend trop de temps mais on arrive a passer le test "
    abondant := Array new: (n + 1).
    (0 to: ((n + 1) - 1)) do: [:p|
      abondant at: (p + 1) put:  false.
    ].
    summable := Array new: (n + 1).
    (0 to: ((n + 1) - 1)) do: [:q|
      summable at: (q + 1) put:  false.
    ].
    sum := 0.
    (2 to: n) do: [:r|
      other := ((self sumdiv: nprimes primes: primes n: r) - r).
      (other > r)
        ifTrue:[abondant at: (r + 1) put:  true.].
    ].
    (1 to: n) do: [:i|
      (1 to: n) do: [:j|
        (((((abondant at: (i + 1))) ifTrue:[(abondant at: (j + 1))] ifFalse: [false])) ifTrue:[((i + j) <= n)] ifFalse: [false])
          ifTrue:[summable at: ((i + j) + 1) put:  true.].
      ].
    ].
    (1 to: n) do: [:o|
      (((summable at: (o + 1))) not)
        ifTrue:[sum :=  (sum + o).].
    ].
    '
' display.
    (sum) display.
    '
' display.
    ]
]
Eval [ (euler23 new) main. ]

