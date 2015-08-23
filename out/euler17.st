Object subclass: euler17 [
  main [
    |one_to_twenty one_to_thirty one_to_ten one_to_sixty one_to_seventy one_to_ninety_nine one_to_ninety one_to_nine one_to_forty one_to_fifty one_to_eighty|(3 + 3 + 5 + 4 + 4) display.
    '
' display.
    one_to_nine := 3 + 3 + 5 + 4 + 4 + 3 + 5 + 5 + 4.
    one_to_nine display.
    '
' display.
    one_to_ten := one_to_nine + 3.
    one_to_twenty := one_to_ten + 6 + 6 + 8 + 8 + 7 + 7 + 9 + 8 + 8 + 6.
    one_to_thirty := one_to_twenty + (6 * 9) + one_to_nine + 6.
    one_to_forty := one_to_thirty + (6 * 9) + one_to_nine + 5.
    one_to_fifty := one_to_forty + (5 * 9) + one_to_nine + 5.
    one_to_sixty := one_to_fifty + (5 * 9) + one_to_nine + 5.
    one_to_seventy := one_to_sixty + (5 * 9) + one_to_nine + 7.
    one_to_eighty := one_to_seventy + (7 * 9) + one_to_nine + 6.
    one_to_ninety := one_to_eighty + (6 * 9) + one_to_nine + 6.
    one_to_ninety_nine := one_to_ninety + (6 * 9) + one_to_nine.
    one_to_ninety_nine display.
    '
' display.
    (100 * one_to_nine + (one_to_ninety_nine * 10) + (10 * 9 * 99) + (7 * 9) + 3 + 8) display.
    '
' display.
    ]
]
Eval [ (euler17 new) main. ]

