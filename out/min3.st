Object subclass: min3 [
  main [
    ((((2) min: (3))) min: (4)) display.
    ' ' display.
    ((((2) min: (4))) min: (3)) display.
    ' ' display.
    ((((3) min: (2))) min: (4)) display.
    ' ' display.
    ((((3) min: (4))) min: (2)) display.
    ' ' display.
    ((((4) min: (2))) min: (3)) display.
    ' ' display.
    ((((4) min: (3))) min: (2)) display.
    '
' display.
    ]
]
Eval [ (min3 new) main. ]

