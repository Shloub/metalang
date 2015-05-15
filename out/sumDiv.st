Object subclass: sumDiv [
  |buffer|
  read_int [|o|
    ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
     o := 0.
    (buffer isNil) ifFalse:[
    (buffer =~ '^(-?\d+)' asRegex) ifMatched: [:match |
    o := match at: 1.
    buffer := buffer allButFirst:(o size).
    ].
    ^o asInteger. ]
  ]
  foo [|a|
    a := 0.
    " test "
    a :=  (a + 1).
    " test 2 "
  ]
  
  foo2 [
    
  ]
  
  foo3 [
    (1 = 1)
      ifTrue:[].
  ]
  
   sumdiv: n  [|out0|
    " On désire renvoyer la somme des diviseurs "
    out0 := 0.
    " On déclare un entier qui contiendra la somme "
    (1 to: n) do: [:i|
      " La boucle : i est le diviseur potentiel"
      ((n rem: i) = 0)
        ifTrue:[
               " Si i divise "
               out0 :=  (out0 + i).
               " On incrémente "
        ]
        ifFalse:[" nop "].
    ].
    ^ out0
    "On renvoie out"
  ]
  
  main [
    |n|" Programme principal "
    n := 0.
    n := self read_int.
    " Lecture de l'entier "
    (self sumdiv: n) display.
    ]
]
Eval [ (sumDiv new) main. ]

