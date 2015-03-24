Object subclass: euler30 [
  main [
    |sum s r p|"
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
"
    p := Array new: 10.
    (0 to: (10 - 1)) do: [:i|
      p at: (i + 1) put:  (i * i * i * i * i).
    ].
    sum := 0.
    (0 to: 9) do: [:a|
      (0 to: 9) do: [:b|
        (0 to: 9) do: [:c|
          (0 to: 9) do: [:d|
            (0 to: 9) do: [:e|
              (0 to: 9) do: [:f|
                s := ((p at: (a + 1)) + (p at: (b + 1)) + (p at: (c + 1)) + (p at: (d + 1)) + (p at: (e + 1)) + (p at: (f + 1))).
                r := (a + (b * 10) + (c * 100) + (d * 1000) + (e * 10000) + (f * 100000)).
                ((s = r) & (r ~= 1))
                  ifTrue:[
                         (f) display.
                         (e) display.
                         (d) display.
                         (c) display.
                         (b) display.
                         (a) display.
                         ' ' display.
                         (r) display.
                         '
' display.
                         sum :=  (sum + r).
                  ].
              ].
            ].
          ].
        ].
      ].
    ].
    (sum) display.
    ]
]
Eval [ (euler30 new) main. ]

