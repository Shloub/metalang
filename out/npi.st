Object subclass: npi [
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
  skip [
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    (buffer =~ '^(\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].
    ]
  ]
  read_char [|o|
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    o := buffer at: 1.
    buffer := buffer allButFirst:1.
    ^o.
    ]
  ]
   is_number: c  [
    ^ (((c) asciiValue) <= (($9) asciiValue)) and: [((c) asciiValue) >= (($0) asciiValue)]
  ]
  
  "
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
"
  
   npi0: str len: len [|stack ptrStr ptrStack num|
    stack := Array new: len.
    (0 to: (len - 1)) do: [:i| stack at: (i + 1) put: 0.].
    ptrStack := 0.
    ptrStr := 0.
    [ptrStr < len] whileTrue:[((str at: (ptrStr + 1)) = $ )
      ifTrue:[ptrStr := ptrStr + 1.]
      ifFalse:[(self is_number: (str at: (ptrStr + 1)))
        ifTrue:[
          num := 0.
          [(str at: (ptrStr + 1)) ~= $ ] whileTrue:[
            num := num * 10 + ((str at: (ptrStr + 1)) asciiValue) - (($0) asciiValue).
            ptrStr := ptrStr + 1.
          ].
          stack at: (ptrStack + 1) put: num.
          ptrStack := ptrStack + 1.
        ]
        ifFalse:[((str at: (ptrStr + 1)) = $+)
          ifTrue:[
            stack at: (ptrStack - 1) put: ((stack at: (ptrStack - 1)) + (stack at: ptrStack)).
            ptrStack := ptrStack - 1.
            ptrStr := ptrStr + 1.
          ].].].].
    ^ stack at: 1
  ]
  main [
    |tmp tab result len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := $ .
      tmp := self read_char.
      tab at: (i + 1) put: tmp.
    ].
    result := (self npi0: tab len: len).
    result display.
    ]
]
Eval [ (npi new) main. ]

