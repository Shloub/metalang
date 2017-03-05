Object subclass: ocaml01 [
  foo [
    (0 to: 10) do: [:i |].
    ^ 0
  ]
  
  bar [|a|
    (0 to: 10) do: [:i| a := 0.].
    ^ 0
  ]
  main [
    
    ]
]
Eval [ (ocaml01 new) main. ]

