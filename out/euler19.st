Object subclass: euler19 [
   is_leap: year  [
    ^ ((year rem: 400) = 0) or: [((year rem: 100) ~= 0) and: [(year rem: 4) = 0]]
  ]
  
   ndayinmonth: month year: year [
    (month = 0)
    ifTrue:[^ 31]
    ifFalse:[(month = 1)
      ifTrue:[(self is_leap: year)
        ifTrue:[^ 29]
        ifFalse:[^ 28].]
      ifFalse:[(month = 2)
        ifTrue:[^ 31]
        ifFalse:[(month = 3)
          ifTrue:[^ 30]
          ifFalse:[(month = 4)
            ifTrue:[^ 31]
            ifFalse:[(month = 5)
              ifTrue:[^ 30]
              ifFalse:[(month = 6)
                ifTrue:[^ 31]
                ifFalse:[(month = 7)
                  ifTrue:[^ 31]
                  ifFalse:[(month = 8)
                    ifTrue:[^ 30]
                    ifFalse:[(month = 9)
                      ifTrue:[^ 31]
                      ifFalse:[(month = 10)
                        ifTrue:[^ 30]
                        ifFalse:[(month = 11)
                          ifTrue:[^ 31].].].].].].].].].].].].
    ^ 0
  ]
  main [
    |year ndays month dayofweek count|month := 0.
    year := 1901.
    dayofweek := 1.
    " 01-01-1901 : mardi "
    count := 0.
    [year ~= 2001] whileTrue:[
      ndays := (self ndayinmonth: month year: year).
      dayofweek := (dayofweek + ndays) rem: 7.
      month := month + 1.
      (month = 12)
      ifTrue:[
        month := 0.
        year := year + 1.
      ].
      ((dayofweek rem: 7) = 6)
      ifTrue:[count := count + 1.].
    ].
    count display.
    '
' display.
    ]
]
Eval [ (euler19 new) main. ]

