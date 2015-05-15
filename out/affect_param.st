Object subclass: affect_param [
   foo: b  [|a|
    a := b.
    a :=  4.
  ]
  
  main [
    |a|a := 0.
    (self foo: a).
    a display.
    '
' display.
    ]
]
Eval [ (affect_param new) main. ]

