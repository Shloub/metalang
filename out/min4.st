Object subclass: min4 [
   min2_: a b: b [
    (a < b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
  main [
    ((self min2_: (self min2_: (self min2_: 1 b: 2) b: 3) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 1 b: 2) b: 4) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 1 b: 3) b: 2) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 1 b: 3) b: 4) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 1 b: 4) b: 2) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 1 b: 4) b: 3) b: 2)) display.
    '
' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 1) b: 3) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 1) b: 4) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 3) b: 1) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 3) b: 4) b: 1)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 4) b: 1) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 2 b: 4) b: 3) b: 1)) display.
    '
' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 1) b: 2) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 1) b: 4) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 2) b: 1) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 2) b: 4) b: 1)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 4) b: 1) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 3 b: 4) b: 2) b: 1)) display.
    '
' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 1) b: 2) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 1) b: 3) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 2) b: 1) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 2) b: 3) b: 1)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 3) b: 1) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: (self min2_: 4 b: 3) b: 2) b: 1)) display.
    '
' display.
    ]
]
Eval [ (min4 new) main. ]

