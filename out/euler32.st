Object subclass: euler32 [
  "
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
"
  
   okdigits: ok n: n [|o digit|
    (n = 0)
    ifTrue:[^ true]
    ifFalse:[
      digit := n rem: 10.
      (ok at: (digit + 1))
      ifTrue:[
        ok at: (digit + 1) put: false.
        o := (self okdigits: ok n: (n quo: 10)).
        ok at: (digit + 1) put: true.
        ^ o
      ]
      ifFalse:[^ false].
    ].
  ]
  main [
    |product2 product counted count be allowed|count := 0.
    allowed := Array new: 10.
    (0 to: 9) do: [:i| allowed at: (i + 1) put: (i ~= 0).].
    counted := Array new: 100000.
    (0 to: 99999) do: [:j| counted at: (j + 1) put: false.].
    (1 to: 9) do: [:e|
      allowed at: (e + 1) put: false.
      (1 to: 9) do: [:b| (allowed at: (b + 1))
        ifTrue:[
          allowed at: (b + 1) put: false.
          be := (b * e) rem: 10.
          (allowed at: (be + 1))
          ifTrue:[
            allowed at: (be + 1) put: false.
            (1 to: 9) do: [:a| (allowed at: (a + 1))
              ifTrue:[
                allowed at: (a + 1) put: false.
                (1 to: 9) do: [:c| (allowed at: (c + 1))
                  ifTrue:[
                    allowed at: (c + 1) put: false.
                    (1 to: 9) do: [:d| (allowed at: (d + 1))
                      ifTrue:[
                        allowed at: (d + 1) put: false.
                        " 2 * 3 digits "
                        product := a * 10 + b * (c * 100 + (d * 10) + e).
                        (((counted at: (product + 1)) not) and: [(self okdigits: allowed n: (product quo: 10))])
                        ifTrue:[
                          counted at: (product + 1) put: true.
                          count := count + product.
                          product display.
                          ' ' display.
                        ].
                        " 1  * 4 digits "
                        product2 := b * (a * 1000 + (c * 100) + (d * 10) + e).
                        (((counted at: (product2 + 1)) not) and: [(self okdigits: allowed n: (product2 quo: 10))])
                        ifTrue:[
                          counted at: (product2 + 1) put: true.
                          count := count + product2.
                          product2 display.
                          ' ' display.
                        ].
                        allowed at: (d + 1) put: true.
                      ].].
                    allowed at: (c + 1) put: true.
                  ].].
                allowed at: (a + 1) put: true.
              ].].
            allowed at: (be + 1) put: true.
          ].
          allowed at: (b + 1) put: true.
        ].].
      allowed at: (e + 1) put: true.
    ].
    count display.
    '
' display.
    ]
]
Eval [ (euler32 new) main. ]

