Object subclass: aaa_04loop [
   h: i  [|j|
    "  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end "
    j := (i - 2).
    [(j <= (i + 2))] whileTrue:
    [
    ((i rem: j) = 5)
      ifTrue:[^ true].
    j :=  (j + 1).
    ].
    ^ false
  ]
  
  main [
    |j i|j := 0.
    (0 to: 10) do: [:k|
      j :=  (j + k).
      (j) display.
      '
' display.
    ].
    i := 4.
    [(i < 10)] whileTrue:
    [
    (i) display.
    i :=  (i + 1).
    j :=  (j + i).
    ].
    (j) display.
    (i) display.
    'FIN TEST
' display.
    ]
]
Eval [ (aaa_04loop new) main. ]

