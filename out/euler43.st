Object subclass: euler43 [
  main [
    |d6 d4 allowed|"
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
"
    allowed := Array new: 10.
    (0 to: (10 - 1)) do: [:i|
      allowed at: (i + 1) put:  true.
    ].
    (0 to: 1) do: [:i6|
      d6 := i6 * 5.
      (allowed at: (d6 + 1))
        ifTrue:[
               allowed at: (d6 + 1) put:  false.
               (0 to: 9) do: [:d7|
                 (allowed at: (d7 + 1))
                   ifTrue:[
                          allowed at: (d7 + 1) put:  false.
                          (0 to: 9) do: [:d8|
                            (allowed at: (d8 + 1))
                              ifTrue:[
                                     allowed at: (d8 + 1) put:  false.
                                     (0 to: 9) do: [:d9|
                                       (allowed at: (d9 + 1))
                                         ifTrue:[
                                                allowed at: (d9 + 1) put:  false.
                                                (1 to: 9) do: [:d10|
                                                  ((((allowed at: (d10 + 1)) and: [((d6 * 100 + (d7 * 10) + d8) rem: 11) = 0]) and: [((d7 * 100 + (d8 * 10) + d9) rem: 13) = 0]) and: [((d8 * 100 + (d9 * 10) + d10) rem: 17) = 0])
                                                    ifTrue:[
                                                           allowed at: (d10 + 1) put:  false.
                                                           (0 to: 9) do: [:d5|
                                                             (allowed at: (d5 + 1))
                                                               ifTrue:[
                                                                      allowed at: (d5 + 1) put:  false.
                                                                      (((d5 * 100 + (d6 * 10) + d7) rem: 7) = 0)
                                                                        ifTrue:[(0 to: 4) do: [:i4|
                                                                                  d4 := i4 * 2.
                                                                                  (allowed at: (d4 + 1))
                                                                                    ifTrue:[
                                                                                           allowed at: (d4 + 1) put:  false.
                                                                                           (0 to: 9) do: [:d3|
                                                                                             (allowed at: (d3 + 1))
                                                                                               ifTrue:[
                                                                                                      allowed at: (d3 + 1) put:  false.
                                                                                                      (((d3 + d4 + d5) rem: 3) = 0)
                                                                                                        ifTrue:[(0 to: 9) do: [:d2|
                                                                                                                  (allowed at: (d2 + 1))
                                                                                                                    ifTrue:[
                                                                                                                           allowed at: (d2 + 1) put:  false.
                                                                                                                           (0 to: 9) do: [:d1|
                                                                                                                             (allowed at: (d1 + 1))
                                                                                                                               ifTrue:[
                                                                                                                                      allowed at: (d1 + 1) put:  false.
                                                                                                                                      d1 display.
                                                                                                                                      d2 display.
                                                                                                                                      d3 display.
                                                                                                                                      d4 display.
                                                                                                                                      d5 display.
                                                                                                                                      d6 display.
                                                                                                                                      d7 display.
                                                                                                                                      d8 display.
                                                                                                                                      d9 display.
                                                                                                                                      d10 display.
                                                                                                                                      ' + ' display.
                                                                                                                                      allowed at: (d1 + 1) put:  true.
                                                                                                                               ].
                                                                                                                           ].
                                                                                                                           allowed at: (d2 + 1) put:  true.
                                                                                                                    ].
                                                                                                               ].].
                                                                                                      allowed at: (d3 + 1) put:  true.
                                                                                               ].
                                                                                           ].
                                                                                           allowed at: (d4 + 1) put:  true.
                                                                                    ].
                                                                               ].].
                                                                      allowed at: (d5 + 1) put:  true.
                                                               ].
                                                           ].
                                                           allowed at: (d10 + 1) put:  true.
                                                    ].
                                                ].
                                                allowed at: (d9 + 1) put:  true.
                                         ].
                                     ].
                                     allowed at: (d8 + 1) put:  true.
                              ].
                          ].
                          allowed at: (d7 + 1) put:  true.
                   ].
               ].
               allowed at: (d6 + 1) put:  true.
        ].
    ].
    0 display.
    '
' display.
    ]
]
Eval [ (euler43 new) main. ]

