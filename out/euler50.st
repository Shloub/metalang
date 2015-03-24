Object subclass: euler50 [
   eratostene: t max0: max0 [|n j|
    n := 0.
    (2 to: (max0 - 1)) do: [:i|
      ((t at: (i + 1)) = i)
        ifTrue:[
               n :=  (n + 1).
               ((max0 quo: i) > i)
                 ifTrue:[
                        j := (i * i).
                        [((j < max0) & (j > 0))] whileTrue:
                        [
                        t at: (j + 1) put:  0.
                        j :=  (j + i).
                        ].
                 ].
        ].
    ].
    ^ n
  ]
  
  main [
    |sum stop resp process primes nprimes maxl maximumprimes len l era|maximumprimes := 1000001.
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
    (l) display.
    ' == ' display.
    (nprimes) display.
    '
' display.
    sum := Array new: nprimes.
    (0 to: (nprimes - 1)) do: [:i_|
      sum at: (i_ + 1) put:  (primes at: (i_ + 1)).
    ].
    maxl := 0.
    process := true.
    stop := (maximumprimes - 1).
    len := 1.
    resp := 1.
    [process] whileTrue:
    [
    process :=  false.
    (0 to: stop) do: [:i|
      (i + len < nprimes)
        ifTrue:[
               sum at: (i + 1) put:  ((sum at: (i + 1)) + (primes at: (i + len + 1))).
               (maximumprimes > (sum at: (i + 1)))
                 ifTrue:[
                        process :=  true.
                        ((era at: ((sum at: (i + 1)) + 1)) = (sum at: (i + 1)))
                          ifTrue:[
                                 maxl :=  len.
                                 resp :=  (sum at: (i + 1)).
                          ].
                 ]
                 ifFalse:[stop :=  ((stop) min: (i)).].
        ].
    ].
    len :=  (len + 1).
    ].
    (resp) display.
    '
' display.
    (maxl) display.
    '
' display.
    ]
]
Eval [ (euler50 new) main. ]

