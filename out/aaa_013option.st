Object subclass: foo [
  | a b c d e f g h |
  a [ ^a ]
  b [ ^b ]
  c [ ^c ]
  d [ ^d ]
  e [ ^e ]
  f [ ^f ]
  g [ ^g ]
  h [ ^h ]
  a: i [ a := i. ] 
  b: i [ b := i. ] 
  c: i [ c := i. ] 
  d: i [ d := i. ] 
  e: i [ e := i. ] 
  f: i [ f := i. ] 
  g: i [ g := i. ] 
  h: i [ h := i. ] 
]
Object subclass: aaa_013option [
   default0: a b: b c: c d: d e: e f: f [
    ^ 0
  ]
  
   aa: b  [
    
  ]
  main [
    '___
' display.
    ]
]
Eval [ (aaa_013option new) main. ]

