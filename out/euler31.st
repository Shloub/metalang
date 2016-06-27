Object subclass: euler31 [
   result: sum t: t maxIndex: maxIndex cache: cache [|out0 div|
    (((cache at: (sum + 1)) at: (maxIndex + 1)) ~= 0)
    ifTrue:[^ (cache at: (sum + 1)) at: (maxIndex + 1)]
    ifFalse:[((sum = 0) or: [maxIndex = 0])
      ifTrue:[^ 1]
      ifFalse:[
        out0 := 0.
        div := sum quo: (t at: (maxIndex + 1)).
        (0 to: div) do: [:i| out0 := out0 + (self result: (sum - (i * (t at: (maxIndex + 1)))) t: t maxIndex: (maxIndex - 1) cache: cache).].
        (cache at: (sum + 1)) at: (maxIndex + 1) put: out0.
        ^ out0
      ].].
  ]
  
  main [
    |t o cache|t := Array new: 8.
    (0 to: (8 - 1)) do: [:i| t at: (i + 1) put: 0.].
    t at: (0 + 1) put: 1.
    t at: (1 + 1) put: 2.
    t at: (2 + 1) put: 5.
    t at: (3 + 1) put: 10.
    t at: (4 + 1) put: 20.
    t at: (5 + 1) put: 50.
    t at: (6 + 1) put: 100.
    t at: (7 + 1) put: 200.
    cache := Array new: 201.
    (0 to: (201 - 1)) do: [:j|
      o := Array new: 8.
      (0 to: (8 - 1)) do: [:k| o at: (k + 1) put: 0.].
      cache at: (j + 1) put: o.
    ].
    (self result: 200 t: t maxIndex: 7 cache: cache) display.
    ]
]
Eval [ (euler31 new) main. ]

