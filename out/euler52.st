Object subclass: euler52 [
   chiffre_sort: a  [|e d c b|
    (a < 10)
      ifTrue:[^ a]
      ifFalse:[
              b := (self chiffre_sort: (a quo: 10)).
              c := (a rem: 10).
              d := (b rem: 10).
              e := (b quo: 10).
              (c < d)
                ifTrue:[^ (c + (b * 10))]
                ifFalse:[^ (d + ((self chiffre_sort: (c + (e * 10))) * 10))].
      ].
  ]
  
   same_numbers: a b: b c: c d: d e: e f: f [|ca|
    ca := (self chiffre_sort: a).
    ^ (((((((((ca = (self chiffre_sort: b))) and: [(ca = (self chiffre_sort: c))])) and: [(ca = (self chiffre_sort: d))])) and: [(ca = (self chiffre_sort: e))])) and: [(ca = (self chiffre_sort: f))])
  ]
  
  main [
    |num|num := 142857.
    (self same_numbers: num b: (num * 2) c: (num * 3) d: (num * 4) e: (num * 6) f: (num * 5))
      ifTrue:[
             (num) display.
             ' ' display.
             (num * 2) display.
             ' ' display.
             (num * 3) display.
             ' ' display.
             (num * 4) display.
             ' ' display.
             (num * 5) display.
             ' ' display.
             (num * 6) display.
             '
' display.
      ].
    ]
]
Eval [ (euler52 new) main. ]

