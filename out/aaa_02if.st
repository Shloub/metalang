Object subclass: aaa_02if [
   f: i  [
    (i = 0)
      ifTrue:[^ true].
    ^ false
  ]
  
  main [
    (self f: 4)
      ifTrue:['true <-
 ->
' display.]
      ifFalse:['false <-
 ->
' display.].
    'small test end
' display.
    ]
]
Eval [ (aaa_02if new) main. ]

