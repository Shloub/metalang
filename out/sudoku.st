Object subclass: sudoku [
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
  " lit un sudoku sur l'entrée standard "
  read_sudoku [|out0 k|
    out0 := Array new: (9 * 9).
    (0 to: (9 * 9 - 1)) do: [:i|
      k := self read_int.
      self skip.
      out0 at: (i + 1) put: k.
    ].
    ^ out0
  ]
  
  " affiche un sudoku "
   print_sudoku: sudoku0  [
    (0 to: 8) do: [:y|
      (0 to: 8) do: [:x|
        (sudoku0 at: (x + (y * 9) + 1)) display.
        ' ' display.
        ((x rem: 3) = 2)
        ifTrue:[' ' display.].
      ].
      '
' display.
      ((y rem: 3) = 2)
      ifTrue:['
' display.].
    ].
    '
' display.
  ]
  
  " dit si les variables sont toutes différentes "
  " dit si les variables sont toutes différentes "
  " dit si le sudoku est terminé de remplir "
   sudoku_done: s  [
    (0 to: 80) do: [:i| ((s at: (i + 1)) = 0)
      ifTrue:[^ false].].
    ^ true
  ]
  
  " dit si il y a une erreur dans le sudoku "
   sudoku_error: s  [|out3 out2 out1|
    out1 := false.
    (0 to: 8) do: [:x| out1 := (((((((((((((((((((((((((((((((((((out1 or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + 9 + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 2) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 2) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 3) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 3) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 3) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 4) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 4) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 4) + 1))]]) or: [((s at: (x + (9 * 3) + 1)) ~= 0) and: [(s at: (x + (9 * 3) + 1)) = (s at: (x + (9 * 4) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 5) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 5) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 5) + 1))]]) or: [((s at: (x + (9 * 3) + 1)) ~= 0) and: [(s at: (x + (9 * 3) + 1)) = (s at: (x + (9 * 5) + 1))]]) or: [((s at: (x + (9 * 4) + 1)) ~= 0) and: [(s at: (x + (9 * 4) + 1)) = (s at: (x + (9 * 5) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + (9 * 3) + 1)) ~= 0) and: [(s at: (x + (9 * 3) + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + (9 * 4) + 1)) ~= 0) and: [(s at: (x + (9 * 4) + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + (9 * 5) + 1)) ~= 0) and: [(s at: (x + (9 * 5) + 1)) = (s at: (x + (9 * 6) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + (9 * 3) + 1)) ~= 0) and: [(s at: (x + (9 * 3) + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + (9 * 4) + 1)) ~= 0) and: [(s at: (x + (9 * 4) + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + (9 * 5) + 1)) ~= 0) and: [(s at: (x + (9 * 5) + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + (9 * 6) + 1)) ~= 0) and: [(s at: (x + (9 * 6) + 1)) = (s at: (x + (9 * 7) + 1))]]) or: [((s at: (x + 1)) ~= 0) and: [(s at: (x + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + 9 + 1)) ~= 0) and: [(s at: (x + 9 + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 2) + 1)) ~= 0) and: [(s at: (x + (9 * 2) + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 3) + 1)) ~= 0) and: [(s at: (x + (9 * 3) + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 4) + 1)) ~= 0) and: [(s at: (x + (9 * 4) + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 5) + 1)) ~= 0) and: [(s at: (x + (9 * 5) + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 6) + 1)) ~= 0) and: [(s at: (x + (9 * 6) + 1)) = (s at: (x + (9 * 8) + 1))]]) or: [((s at: (x + (9 * 7) + 1)) ~= 0) and: [(s at: (x + (9 * 7) + 1)) = (s at: (x + (9 * 8) + 1))]].].
    out2 := false.
    (0 to: 8) do: [:x| out2 := (((((((((((((((((((((((((((((((((((out2 or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 1 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 2 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 2 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 3 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 3 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 3 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 4 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 4 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 4 + 1))]]) or: [((s at: (x * 9 + 3 + 1)) ~= 0) and: [(s at: (x * 9 + 3 + 1)) = (s at: (x * 9 + 4 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 5 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 5 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 5 + 1))]]) or: [((s at: (x * 9 + 3 + 1)) ~= 0) and: [(s at: (x * 9 + 3 + 1)) = (s at: (x * 9 + 5 + 1))]]) or: [((s at: (x * 9 + 4 + 1)) ~= 0) and: [(s at: (x * 9 + 4 + 1)) = (s at: (x * 9 + 5 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 3 + 1)) ~= 0) and: [(s at: (x * 9 + 3 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 4 + 1)) ~= 0) and: [(s at: (x * 9 + 4 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 5 + 1)) ~= 0) and: [(s at: (x * 9 + 5 + 1)) = (s at: (x * 9 + 6 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 3 + 1)) ~= 0) and: [(s at: (x * 9 + 3 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 4 + 1)) ~= 0) and: [(s at: (x * 9 + 4 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 5 + 1)) ~= 0) and: [(s at: (x * 9 + 5 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 6 + 1)) ~= 0) and: [(s at: (x * 9 + 6 + 1)) = (s at: (x * 9 + 7 + 1))]]) or: [((s at: (x * 9 + 1)) ~= 0) and: [(s at: (x * 9 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 1 + 1)) ~= 0) and: [(s at: (x * 9 + 1 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 2 + 1)) ~= 0) and: [(s at: (x * 9 + 2 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 3 + 1)) ~= 0) and: [(s at: (x * 9 + 3 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 4 + 1)) ~= 0) and: [(s at: (x * 9 + 4 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 5 + 1)) ~= 0) and: [(s at: (x * 9 + 5 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 6 + 1)) ~= 0) and: [(s at: (x * 9 + 6 + 1)) = (s at: (x * 9 + 8 + 1))]]) or: [((s at: (x * 9 + 7 + 1)) ~= 0) and: [(s at: (x * 9 + 7 + 1)) = (s at: (x * 9 + 8 + 1))]].].
    out3 := false.
    (0 to: 8) do: [:x| out3 := (((((((((((((((((((((((((((((((((((out3 or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 1 * 9 + ((x quo: 3) * 3) + 2 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]]) or: [((s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1)) ~= 0) and: [(s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 1 + 1)) = (s at: ((x rem: 3) * 3 + 2 * 9 + ((x quo: 3) * 3) + 2 + 1))]].].
    ^ (out1 or: [out2]) or: [out3]
  ]
  
  " résout le sudoku"
   solve: sudoku0  [
    (self sudoku_error: sudoku0)
    ifTrue:[^ false].
    (self sudoku_done: sudoku0)
    ifTrue:[^ true].
    (0 to: 80) do: [:i| ((sudoku0 at: (i + 1)) = 0)
      ifTrue:[
        (1 to: 9) do: [:p|
          sudoku0 at: (i + 1) put: p.
          (self solve: sudoku0)
          ifTrue:[^ true].
        ].
        sudoku0 at: (i + 1) put: 0.
        ^ false
      ].].
    ^ false
  ]
  
  main [
    |sudoku0|sudoku0 := (self read_sudoku).
    (self print_sudoku:sudoku0).
    (self solve: sudoku0)
    ifTrue:[(self print_sudoku:sudoku0).]
    ifFalse:['no solution
' display.].
    ]
]
Eval [ (sudoku new) main. ]

