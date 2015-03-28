Object subclass: aaa_10stringsarray [
  "
TODO ajouter un record qui contient des chaines.
"
   idstring: s  [
    ^ s
  ]
  
   printstring: s  [
    ((self idstring: s)) display.
    '
' display.
  ]
  
  main [
    |tab|tab := Array new: 2.
    (0 to: (2 - 1)) do: [:i|
      tab at: (i + 1) put:  (self idstring: 'chaine de test').
    ].
    (0 to: 1) do: [:j|
      (self printstring: (self idstring: (tab at: (j + 1)))).
    ].
    ]
]
Eval [ (aaa_10stringsarray new) main. ]

