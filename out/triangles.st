Object subclass: triangles [
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
  " Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
"
   find0: len tab: tab cache: cache x: x y: y [|result out1 out0|
    "
	Cette fonction est récursive
	"
    (y = (len - 1))
      ifTrue:[^ (tab at: (y + 1)) at: (x + 1)]
      ifFalse:[(x > y)
                ifTrue:[^ 0 - 10000]
                ifFalse:[(((cache at: (y + 1)) at: (x + 1)) ~= 0)
                          ifTrue:[^ (cache at: (y + 1)) at: (x + 1)].].].
    result := 0.
    out0 := (self find0: len tab: tab cache: cache x: x y: (y + 1)).
    out1 := (self find0: len tab: tab cache: cache x: (x + 1) y: (y + 1)).
    (out0 > out1)
      ifTrue:[result :=  (out0 + ((tab at: (y + 1)) at: (x + 1))).]
      ifFalse:[result :=  (out1 + ((tab at: (y + 1)) at: (x + 1))).].
    (cache at: (y + 1)) at: (x + 1) put:  result.
    ^ result
  ]
  
   find: len tab: tab [|tab3 tab2|
    tab2 := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tab3 := Array new: (i + 1).
      (0 to: (i + 1 - 1)) do: [:j|
        tab3 at: (j + 1) put:  0.
      ].
      tab2 at: (i + 1) put:  tab3.
    ].
    ^ (self find0: len tab: tab cache: tab2 x: 0 y: 0)
  ]
  
  main [
    |tmp tab2 tab len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tab2 := Array new: (i + 1).
      (0 to: (i + 1 - 1)) do: [:j|
        tmp := 0.
        tmp := self read_int.
        self skip.
        tab2 at: (j + 1) put:  tmp.
      ].
      tab at: (i + 1) put:  tab2.
    ].
    (self find: len tab: tab) display.
    '
' display.
    (0 to: (len - 1)) do: [:k|
      (0 to: k) do: [:l|
        ((tab at: (k + 1)) at: (l + 1)) display.
        ' ' display.
      ].
      '
' display.
    ].
    ]
]
Eval [ (triangles new) main. ]

