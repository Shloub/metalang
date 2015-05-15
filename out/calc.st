Object subclass: calc [
  "
La suite de fibonaci
"
   fibo: a b: b i: i [|tmp out_ b2 a2|
    out_ := 0.
    a2 := a.
    b2 := b.
    (0 to: (i + 1)) do: [:j|
      j display.
      out_ :=  (out_ + a2).
      tmp := b2.
      b2 :=  (b2 + a2).
      a2 :=  tmp.
    ].
    ^ out_
  ]
  
  main [
    (self fibo: 1 b: 2 i: 4) display.
    ]
]
Eval [ (calc new) main. ]

