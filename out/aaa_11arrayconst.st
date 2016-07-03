Object subclass: aaa_11arrayconst [
   test: tab len: len [
    (0 to: (len - 1)) do: [:i| (tab at: (i + 1)) display.
      ' ' display.].
    '
' display.
  ]
  
  main [
    |t|t := Array new: 5.
    (0 to: 4) do: [:i| t at: (i + 1) put: 1.].
    (self test:t len:5).
    ]
]
Eval [ (aaa_11arrayconst new) main. ]

