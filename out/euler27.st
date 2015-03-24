Object subclass: euler27 [
   eratostene: t max0: max0 [|n j|
    n := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               n :=  (n + 1).
               j := (i * i).
               [((j < max0) & (j > 0))] whileTrue:
               [
               t at: (j + 1) put:  0.
               j :=  (j + i).
               ].
        ].
    ].
    ^ n
  ]
  
   isPrime: c primes: primes len: len [|n i|
    n := c.
    i := 0.
    (n < 0)
      ifTrue:[n :=  (0-(n)).].
    [((primes at: (i + 1)) * (primes at: (i + 1)) < n)] whileTrue:
    [
    ((n rem: (primes at: (i + 1))) = 0)
      ifTrue:[^ false].
    i :=  (i + 1).
    ].
    ^ true
  ]
  
   test: a b: b primes: primes len: len [|j|
    (0 to: 200) do: [:n|
      j := (n * n + (a * n) + b).
      (((self isPrime: j primes: primes len: len)) not)
        ifTrue:[^ n].
    ].
    ^ 200
  ]
  
  main [
    |result primes nprimes n2 n1 mb maximumprimes max0 ma l era|maximumprimes := 1000.
    era := Array new: maximumprimes.
    (0 to: (maximumprimes - 1)) do: [:j|
      era at: (j + 1) put:  j.
    ].
    result := 0.
    max0 := 0.
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
    (l) display.
    ' == ' display.
    (nprimes) display.
    '
' display.
    ma := 0.
    mb := 0.
    (3 to: 999) do: [:b|
      ((era at: (b + 1)) = b)
        ifTrue:[((0-(999)) to: 999) do: [:a|
                  n1 := (self test: a b: b primes: primes len: nprimes).
                  n2 := (self test: a b: (0-(b)) primes: primes len: nprimes).
                  (n1 > max0)
                    ifTrue:[
                           max0 :=  n1.
                           result :=  (a * b).
                           ma :=  a.
                           mb :=  b.
                    ].
                  (n2 > max0)
                    ifTrue:[
                           max0 :=  n2.
                           result :=  ((0-(a)) * b).
                           ma :=  a.
                           mb :=  (0-(b)).
                    ].
               ].].
    ].
    (ma) display.
    ' ' display.
    (mb) display.
    '
' display.
    (max0) display.
    '
' display.
    (result) display.
    '
' display.
    ]
]
Eval [ (euler27 new) main. ]

