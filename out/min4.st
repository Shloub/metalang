Object subclass: min4 [
  main [
    ((((((1) min: (2))) min: (3))) min: (4)) display.
    ' ' display.
    ((((((1) min: (2))) min: (4))) min: (3)) display.
    ' ' display.
    ((((((1) min: (3))) min: (2))) min: (4)) display.
    ' ' display.
    ((((((1) min: (3))) min: (4))) min: (2)) display.
    ' ' display.
    ((((((1) min: (4))) min: (2))) min: (3)) display.
    ' ' display.
    ((((((1) min: (4))) min: (3))) min: (2)) display.
    '
' display.
    ((((((2) min: (1))) min: (3))) min: (4)) display.
    ' ' display.
    ((((((2) min: (1))) min: (4))) min: (3)) display.
    ' ' display.
    ((((((2) min: (3))) min: (1))) min: (4)) display.
    ' ' display.
    ((((((2) min: (3))) min: (4))) min: (1)) display.
    ' ' display.
    ((((((2) min: (4))) min: (1))) min: (3)) display.
    ' ' display.
    ((((((2) min: (4))) min: (3))) min: (1)) display.
    '
' display.
    ((((((3) min: (1))) min: (2))) min: (4)) display.
    ' ' display.
    ((((((3) min: (1))) min: (4))) min: (2)) display.
    ' ' display.
    ((((((3) min: (2))) min: (1))) min: (4)) display.
    ' ' display.
    ((((((3) min: (2))) min: (4))) min: (1)) display.
    ' ' display.
    ((((((3) min: (4))) min: (1))) min: (2)) display.
    ' ' display.
    ((((((3) min: (4))) min: (2))) min: (1)) display.
    '
' display.
    ((((((4) min: (1))) min: (2))) min: (3)) display.
    ' ' display.
    ((((((4) min: (1))) min: (3))) min: (2)) display.
    ' ' display.
    ((((((4) min: (2))) min: (1))) min: (3)) display.
    ' ' display.
    ((((((4) min: (2))) min: (3))) min: (1)) display.
    ' ' display.
    ((((((4) min: (3))) min: (1))) min: (2)) display.
    ' ' display.
    ((((((4) min: (3))) min: (2))) min: (1)) display.
    '
' display.
    ]
]
Eval [ (min4 new) main. ]

