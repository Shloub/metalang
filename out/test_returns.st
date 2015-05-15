Object subclass: test_returns [
   is_pair: i  [|j|
    j := 1.
    (i < 10)
      ifTrue:[
             j :=  2.
             (i = 0)
               ifTrue:[
                      j :=  4.
                      ^ true
               ].
             j :=  3.
             (i = 2)
               ifTrue:[
                      j :=  4.
                      ^ true
               ].
             j :=  5.
      ].
    j :=  6.
    (i < 20)
      ifTrue:[
             (i = 22)
               ifTrue:[j :=  0.].
             j :=  8.
      ].
    ^ (i rem: 2) = 0
  ]
  
  main [
    
    ]
]
Eval [ (test_returns new) main. ]

