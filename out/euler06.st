Object subclass: euler06 [
  main [
    |sumcarres sum lim carressum|lim := 100.
    sum := ((lim * (lim + 1)) quo: 2).
    carressum := (sum * sum).
    sumcarres := ((lim * (lim + 1) * (2 * lim + 1)) quo: 6).
    (carressum - sumcarres) display.
    ]
]
Eval [ (euler06 new) main. ]

