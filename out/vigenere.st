Object subclass: vigenere [
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
   position_alphabet: c  [|i|
    i := ((c) asciiValue).
    ((i <= (($Z) asciiValue)) and: [i >= (($A) asciiValue)])
      ifTrue:[^ i - (($A) asciiValue)]
      ifFalse:[((i <= (($z) asciiValue)) and: [i >= (($a) asciiValue)])
                ifTrue:[^ i - (($a) asciiValue)]
                ifFalse:[^ 0 - 1].].
  ]
  
   of_position_alphabet: c  [
    ^ ((c + (($a) asciiValue)) asCharacter)
  ]
  
   crypte: taille_cle cle: cle taille: taille message: message [|new0 lettre addon|
    (0 to: (taille - 1)) do: [:i|
      lettre := (self position_alphabet: (message at: (i + 1))).
      (lettre ~= (0 - 1))
        ifTrue:[
               addon := (self position_alphabet: (cle at: ((i rem: taille_cle) + 1))).
               new0 := (addon + lettre) rem: 26.
               message at: (i + 1) put:  (self of_position_alphabet: new0).
        ].
    ].
  ]
  
  main [
    |taille_cle taille out2 out0 message cle|taille_cle := self read_int.
    self skip.
    cle := Array new: taille_cle.
    (0 to: (taille_cle - 1)) do: [:index|
      out0 := self read_char.
      cle at: (index + 1) put:  out0.
    ].
    self skip.
    taille := self read_int.
    self skip.
    message := Array new: taille.
    (0 to: (taille - 1)) do: [:index2|
      out2 := self read_char.
      message at: (index2 + 1) put:  out2.
    ].
    (self crypte: taille_cle cle: cle taille: taille message: message).
    (0 to: (taille - 1)) do: [:i|
      (message at: (i + 1)) display.
    ].
    '
' display.
    ]
]
Eval [ (vigenere new) main. ]

