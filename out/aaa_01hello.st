Object subclass: aaa_01hello [
  main [
    |e d c b a|'Hello World' display.
    a := 5.
    (4 + 6 * 2) display.
    ' ' display.
    '
' display.
    (a) display.
    'foo' display.
    '' display.
    b := (((1 + ((1 + 1 * 2 * (3 + 8)) quo: 4) - (1 - 2) - 3 = 12)) and: [true]).
    b
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    '
' display.
    c := (3 * (4 + 5 + 6) * 2 = 45 = false).
    c
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    (((4 + 1) quo: 3) quo: (2 + 1)) display.
    (((4 * 1) quo: 3) quo: (2 * 1)) display.
    d := (((((((a = 0)) not)) and: [(((a = 4)) not)])) not).
    d
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    e := ((((true) and: [((false) not)])) and: [((((true) and: [false])) not)]).
    e
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    '
' display.
    ]
]
Eval [ (aaa_01hello new) main. ]

