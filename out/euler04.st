Object subclass: euler04 [
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
      ifTrue:[^ (m rem: 10)]
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
                mul := (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f)).
                ((((((self chiffre: 0 m: mul) = (self chiffre: 5 m: mul))) ifTrue:[((self chiffre: 1 m: mul) = (self chiffre: 4 m: mul))] ifFalse: [false])) ifTrue:[((self chiffre: 2 m: mul) = (self chiffre: 3 m: mul))] ifFalse: [false])
                  ifTrue:[m :=  (self max2_: mul b: m).].
              ].
            ].
          ].
        ].
      ].
    ].
    (m) display.
    '
' display.
    ]
]
Eval [ (euler04 new) main. ]

