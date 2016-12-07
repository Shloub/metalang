Object subclass: aaa_021if [
   testA: a b: b [
    a
    ifTrue:[b
      ifTrue:['A' display.]
      ifFalse:['B' display.].]
    ifFalse:[b
      ifTrue:['C' display.]
      ifFalse:['D' display.].].
  ]
  
   testB: a b: b [
    a
    ifTrue:['A' display.]
    ifFalse:[b
      ifTrue:['B' display.]
      ifFalse:['C' display.].].
  ]
  
   testC: a b: b [
    a
    ifTrue:[b
      ifTrue:['A' display.]
      ifFalse:['B' display.].]
    ifFalse:['C' display.].
  ]
  
   testD: a b: b [
    a
    ifTrue:[
      b
      ifTrue:['A' display.]
      ifFalse:['B' display.].
      'C' display.
    ]
    ifFalse:['D' display.].
  ]
  
   testE: a b: b [
    a
    ifTrue:[b
      ifTrue:['A' display.].]
    ifFalse:[
      b
      ifTrue:['C' display.]
      ifFalse:['D' display.].
      'E' display.
    ].
  ]
  
   test: a b: b [
    (self testD:a b:b).
    (self testE:a b:b).
    '
' display.
  ]
  
  main [
    (self test:true b:true).
    (self test:true b:false).
    (self test:false b:true).
    (self test:false b:false).
    ]
]
Eval [ (aaa_021if new) main. ]

