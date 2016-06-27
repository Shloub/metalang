Object subclass: aaa_03binding [
   g: i  [|j|
    j := i * 4.
    ((j rem: 2) = 1)
    ifTrue:[^ 0].
    ^ j
  ]
  
   h: i  [
    i display.
    '
' display.
  ]
  
  main [
    |b a|(self h:14).
    a := 4.
    b := 5.
    (a + b) display.
    " main "
    (self h:15).
    a := 2.
    b := 1.
    (a + b) display.
    ]
]
Eval [ (aaa_03binding new) main. ]

