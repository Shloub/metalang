Object subclass: sort [
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
   copytab: tab len: len [|o|
    o := Array new: len.
    (0 to: (len - 1)) do: [:i|
      o at: (i + 1) put:  (tab at: (i + 1)).
    ].
    ^ o
  ]
  
   bubblesort: tab len: len [|tmp|
    (0 to: (len - 1)) do: [:i|
      ((i + 1) to: (len - 1)) do: [:j|
        ((tab at: (i + 1)) > (tab at: (j + 1)))
          ifTrue:[
                 tmp := (tab at: (i + 1)).
                 tab at: (i + 1) put:  (tab at: (j + 1)).
                 tab at: (j + 1) put:  tmp.
          ].
      ].
    ].
  ]
  
   qsort0: tab len: len a: a b: b [|tmp j0 j i0 i|
    i := a.
    j := b.
    (i < j)
      ifTrue:[
             i0 := i.
             j0 := j.
             " pivot : tab[0] "
             [(i ~= j)] whileTrue:
             [((tab at: (i + 1)) > (tab at: (j + 1)))
               ifTrue:[(i = (j - 1))
                        ifTrue:[
                               " on inverse simplement"
                               tmp := (tab at: (i + 1)).
                               tab at: (i + 1) put:  (tab at: (j + 1)).
                               tab at: (j + 1) put:  tmp.
                               i :=  (i + 1).
                        ]
                        ifFalse:[
                                " on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] "
                                tmp := (tab at: (i + 1)).
                                tab at: (i + 1) put:  (tab at: (j + 1)).
                                tab at: (j + 1) put:  (tab at: ((i + 1) + 1)).
                                tab at: ((i + 1) + 1) put:  tmp.
                                i :=  (i + 1).
                        ].]
               ifFalse:[j :=  (j - 1).].].
             (self qsort0: tab
             len: len
             a: i0
             b: (i - 1)).
             (self qsort0: tab
             len: len
             a: (i + 1)
             b: j0).
      ].
  ]
  
  main [
    |tmp tab3 tab2 tab len|len := 2.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i_|
      tmp := 0.
      tmp := self read_int.
      self skip.
      tab at: (i_ + 1) put:  tmp.
    ].
    tab2 := (self copytab: tab len: len).
    (self bubblesort: tab2
    len: len).
    (0 to: (len - 1)) do: [:i|
      ((tab2 at: (i + 1))) display.
      ' ' display.
    ].
    '
' display.
    tab3 := (self copytab: tab len: len).
    (self qsort0: tab3
    len: len
    a: 0
    b: (len - 1)).
    (0 to: (len - 1)) do: [:i|
      ((tab3 at: (i + 1))) display.
      ' ' display.
    ].
    '
' display.
    ]
]
Eval [ (sort new) main. ]

