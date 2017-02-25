Object subclass: test_instant [
   foo: a b: b [
    ^ a + b
  ]
  main [
    10 display.
    ]
]
Eval [ (test_instant new) main. ]

