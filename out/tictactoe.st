Object subclass: gamestate [
  | cases firstToPlay note ended |
  cases [ ^cases ]
  firstToPlay [ ^firstToPlay ]
  note [ ^note ]
  ended [ ^ended ]
  cases: e [ cases := e. ] 
  firstToPlay: e [ firstToPlay := e. ] 
  note: e [ note := e. ] 
  ended: e [ ended := e. ] 
]
Object subclass: move [
  | x y |
  x [ ^x ]
  y [ ^y ]
  x: f [ x := f. ] 
  y: f [ y := f. ] 
]
Object subclass: tictactoe [
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
  "
Tictactoe : un tictactoe avec une IA
"
  
  " La structure de donnée "
  
  " Un Mouvement "
  
  " On affiche l'état "
  
   print_state: g  [
    '
|' display.
    (0 to: 2) do: [:y|
      (0 to: 2) do: [:x|
        (((g cases at: (x + 1)) at: (y + 1)) = 0)
        ifTrue:[' ' display.]
        ifFalse:[(((g cases at: (x + 1)) at: (y + 1)) = 1)
          ifTrue:['O' display.]
          ifFalse:['X' display.].].
        '|' display.
      ].
      (y ~= 2)
      ifTrue:['
|-|-|-|
|' display.].
    ].
    '
' display.
  ]
  
  " On dit qui gagne (info stoquées dans g.ended et g.note ) "
  
   eval0: g  [|win linv lin freecase colv col|
    win := 0.
    freecase := 0.
    (0 to: 2) do: [:y|
      col := 0 - 1.
      lin := 0 - 1.
      (0 to: 2) do: [:x|
        (((g cases at: (x + 1)) at: (y + 1)) = 0)
        ifTrue:[freecase := freecase + 1.].
        colv := (g cases at: (x + 1)) at: (y + 1).
        linv := (g cases at: (y + 1)) at: (x + 1).
        ((col = (0 - 1)) and: [colv ~= 0])
        ifTrue:[col := colv.]
        ifFalse:[(colv ~= col)
          ifTrue:[col := 0 - 2.].].
        ((lin = (0 - 1)) and: [linv ~= 0])
        ifTrue:[lin := linv.]
        ifFalse:[(linv ~= lin)
          ifTrue:[lin := 0 - 2.].].
      ].
      (col >= 0)
      ifTrue:[win := col.]
      ifFalse:[(lin >= 0)
        ifTrue:[win := lin.].].
    ].
    (1 to: 2) do: [:x|
      (((((g cases at: 1) at: 1) = x) and: [((g cases at: 2) at: 2) = x]) and: [((g cases at: 3) at: 3) = x])
      ifTrue:[win := x.].
      (((((g cases at: 1) at: 3) = x) and: [((g cases at: 2) at: 2) = x]) and: [((g cases at: 3) at: 1) = x])
      ifTrue:[win := x.].
    ].
    g ended: ((win ~= 0) or: [freecase = 0]).
    (win = 1)
    ifTrue:[g note: 1000.]
    ifFalse:[(win = 2)
      ifTrue:[g note: (0 - 1000).]
      ifFalse:[g note: 0.].].
  ]
  
  " On applique un mouvement "
  
   apply_move_xy: x y: y g: g [|player|
    player := 2.
    g firstToPlay
    ifTrue:[player := 1.].
    (g cases at: (x + 1)) at: (y + 1) put: player.
    g firstToPlay: (g firstToPlay not).
  ]
  
   apply_move: m g: g [
    (self apply_move_xy:m x y:m y g:g).
  ]
  
   cancel_move_xy: x y: y g: g [
    (g cases at: (x + 1)) at: (y + 1) put: 0.
    g firstToPlay: (g firstToPlay not).
    g ended: false.
  ]
  
   cancel_move: m g: g [
    (self cancel_move_xy:m x y:m y g:g).
  ]
  
   can_move_xy: x y: y g: g [
    ^ ((g cases at: (x + 1)) at: (y + 1)) = 0
  ]
  
   can_move: m g: g [
    ^ (self can_move_xy: m x y: m y g: g)
  ]
  
  "
Un minimax classique, renvoie la note du plateau
"
  
   minmax: g  [|maxNote currentNote|
    (self eval0:g).
    g ended
    ifTrue:[^ g note].
    maxNote := 0 - 10000.
    (g firstToPlay not)
    ifTrue:[maxNote := 10000.].
    (0 to: 2) do: [:x| (0 to: 2) do: [:y| (self can_move_xy: x y: y g: g)
                         ifTrue:[
                           (self apply_move_xy:x y:y g:g).
                           currentNote := (self minmax: g).
                           (self cancel_move_xy:x y:y g:g).
                           " Minimum ou Maximum selon le coté ou l'on joue"
                           (currentNote > maxNote = g firstToPlay)
                           ifTrue:[maxNote := currentNote.].
                         ].].].
    ^ maxNote
  ]
  
  "
Renvoie le coup de l'IA
"
  
   play: g  [|minNote minMove currentNote|
    minMove := move new.
    minMove x: 0.
    minMove y: 0.
    minNote := 10000.
    (0 to: 2) do: [:x| (0 to: 2) do: [:y| (self can_move_xy: x y: y g: g)
                         ifTrue:[
                           (self apply_move_xy:x y:y g:g).
                           currentNote := (self minmax: g).
                           x display.
                           ', ' display.
                           y display.
                           ', ' display.
                           currentNote display.
                           '
' display.
                           (self cancel_move_xy:x y:y g:g).
                           (currentNote < minNote)
                           ifTrue:[
                             minNote := currentNote.
                             minMove x: x.
                             minMove y: y.
                           ].
                         ].].].
    minMove x display.
    minMove y display.
    '
' display.
    ^ minMove
  ]
  
  init0 [|tab cases a|
    cases := Array new: 3.
    (0 to: 2) do: [:i|
      tab := Array new: 3.
      (0 to: 2) do: [:j| tab at: (j + 1) put: 0.].
      cases at: (i + 1) put: tab.
    ].
    a := gamestate new.
    a cases: cases.
    a firstToPlay: true.
    a note: 0.
    a ended: false.
    ^ a
  ]
  
  read_move [|y x b|
    x := self read_int.
    self skip.
    y := self read_int.
    self skip.
    b := move new.
    b x: x.
    b y: y.
    ^ b
  ]
  main [
    |state d c|(0 to: 1) do: [:i|
                 state := (self init0).
                 c := move new.
                 c x: 1.
                 c y: 1.
                 (self apply_move:c g:state).
                 d := move new.
                 d x: 0.
                 d y: 0.
                 (self apply_move:d g:state).
                 [state ended not] whileTrue:[
                   (self print_state:state).
                   (self apply_move:(self play: state) g:state).
                   (self eval0:state).
                   (self print_state:state).
                   (state ended not)
                   ifTrue:[
                     (self apply_move:(self play: state) g:state).
                     (self eval0:state).
                   ].
                 ].
                 (self print_state:state).
                 state note display.
                 '
' display.
    ].
    ]
]
Eval [ (tictactoe new) main. ]

