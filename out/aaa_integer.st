Object subclass: aaa_integer [
  main [
    |i|i := 0.
    i := i - 1.
    i display.
    '
' display.
    i := i + 55.
    i display.
    '
' display.
    i := i * 13.
    i display.
    '
' display.
    i := i quo: 2.
    i display.
    '
' display.
    i := i + 1.
    i display.
    '
' display.
    i := i quo: 3.
    i display.
    '
' display.
    i := i - 1.
    i display.
    '
' display.
    "
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
"
    (117 quo: 17) display.
    '
' display.
    (117 quo: (0 - 17)) display.
    '
' display.
    ((0 - 117) quo: 17) display.
    '
' display.
    ((0 - 117) quo: (0 - 17)) display.
    '
' display.
    (117 rem: 17) display.
    '
' display.
    (117 rem: (0 - 17)) display.
    '
' display.
    ((0 - 117) rem: 17) display.
    '
' display.
    ((0 - 117) rem: (0 - 17)) display.
    '
' display.
    ]
]
Eval [ (aaa_integer new) main. ]

