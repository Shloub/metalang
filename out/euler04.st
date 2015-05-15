Object subclass: euler04 [
  "

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

"
   chiffre: c m: m [
    (c = 0)
      ifTrue:[^ m rem: 10]
      ifFalse:[^ (self chiffre: (c - 1) m: (m quo: 10))].
  ]
  
  main [
    |mul m|m := 1.
    (0 to: 9) do: [:a|
      (1 to: 9) do: [:f|
        (0 to: 9) do: [:d|
          (1 to: 9) do: [:c|
            (0 to: 9) do: [:b|
              (0 to: 9) do: [:e|
                mul := a * d + (10 * (a * e + (b * d))) + (100 * (a * f + (b * e) + (c * d))) + (1000 * (c * e + (b * f))) + (10000 * c * f).
                ((((self chiffre: 0 m: mul) = (self chiffre: 5 m: mul)) and: [(self chiffre: 1 m: mul) = (self chiffre: 4 m: mul)]) and: [(self chiffre: 2 m: mul) = (self chiffre: 3 m: mul)])
                  ifTrue:[m :=  ((mul) max: (m)).].
              ].
            ].
          ].
        ].
      ].
    ].
    m display.
    '
' display.
    ]
]
Eval [ (euler04 new) main. ]

