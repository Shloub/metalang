Object subclass: aaa_041comment [
  main [
    |i|i := 4.
    "while i < 10 do "
    (i) display.
    i :=  (i + 1).
    "  end "
    (i) display.
    ]
]
Eval [ (aaa_041comment new) main. ]

