Object subclass: aaa_01hello [
  main [
    |a|'Hello World' display.
    a := 5.
    (4 + 6 * 2) display.
    ' 
' display.
    a display.
    'foo' display.
    ((1 + ((2 * 2 * (3 + 8)) quo: 4) - 2 = 12) and: [true])
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    '
' display.
    (3 * (4 + 11) * 2 = 45 = false)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    ' ' display.
    (2 = 1 = false)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    ' ' display.
    ((5 quo: 3) quo: 3) display.
    (((4 * 1) quo: 3) quo: (2 * 1)) display.
    ((((a = 0) not) and: [(a = 4) not]) not)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    ((true and: [false not]) and: [(true and: [false]) not])
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    '
' display.
    ]
]
Eval [ (aaa_01hello new) main. ]

