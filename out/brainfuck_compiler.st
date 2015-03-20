Object subclass: brainfuck_compiler [
  "
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
"
  main [
    |mem input current_pos|input := $ .
    current_pos := 500.
    mem := Array new: 1000.
    (0 to: (1000 - 1)) do: [:i|
      mem at: (i + 1) put:  0.
    ].
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    current_pos :=  (current_pos + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    [((mem at: (current_pos + 1)) ~= 0)] whileTrue:
    [
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) - 1).
    current_pos :=  (current_pos - 1).
    mem at: (current_pos + 1) put:  ((mem at: (current_pos + 1)) + 1).
    ((((mem at: (current_pos + 1))) asCharacter)) display.
    current_pos :=  (current_pos + 1).
    ].
    ]
]
Eval [ (brainfuck_compiler new) main. ]

