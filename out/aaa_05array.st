Object subclass: aaa_05array [
   id: b  [
    ^ b
  ]
  
   g: t index: index [
    t at: (index + 1) put: false.
  ]
  main [
    |j a|j := 0.
    a := Array new: 5.
    (0 to: 4) do: [:i|
      i display.
      j := j + i.
      a at: (i + 1) put: ((i rem: 2) = 0).
    ].
    j display.
    ' ' display.
    (a at: 1)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    '
' display.
    (self g:(self id: a) index:0).
    (a at: 1)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    '
' display.
    ]
]
Eval [ (aaa_05array new) main. ]

