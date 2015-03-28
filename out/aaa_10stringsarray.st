Object subclass: toto [
  | s v |
  s [ ^s ]
  v [ ^v ]
  s: b [ s := b. ] 
  v: b [ v := b. ] 
]
Object subclass: aaa_10stringsarray [
  
   idstring: s  [
    ^ s
  ]
  
   printstring: s  [
    ((self idstring: s)) display.
    '
' display.
  ]
  
   print_toto: t  [
    ((t s)) display.
    ' = ' display.
    ((t v)) display.
    '
' display.
  ]
  
  main [
    |tab a|tab := Array new: 2.
    (0 to: (2 - 1)) do: [:i|
      tab at: (i + 1) put:  (self idstring: 'chaine de test').
    ].
    (0 to: 1) do: [:j|
      (self printstring: (self idstring: (tab at: (j + 1)))).
    ].
    a := toto new.
    a s: 'one'.
    a v: 1.
    (self print_toto: a).
    ]
]
Eval [ (aaa_10stringsarray new) main. ]

