Object subclass: euler17 [
  main [
    |two twenty twelve three thousand thirty thirteen ten sixty sixteen six seventy seventeen seven one_to_twenty one_to_thirty one_to_ten one_to_sixty one_to_seventy one_to_ninety_nine one_to_ninety one_to_nine one_to_forty one_to_fifty one_to_eighty one ninety nineteen nine hundred_and hundred fourteen four forty five fifty fifteen eleven eighty eighteen eight|one := 3.
    two := 3.
    three := 5.
    four := 4.
    five := 4.
    six := 3.
    seven := 5.
    eight := 5.
    nine := 4.
    ten := 3.
    eleven := 6.
    twelve := 6.
    thirteen := 8.
    fourteen := 8.
    fifteen := 7.
    sixteen := 7.
    seventeen := 9.
    eighteen := 8.
    nineteen := 8.
    twenty := 6.
    thirty := 6.
    forty := 5.
    fifty := 5.
    sixty := 5.
    seventy := 7.
    eighty := 6.
    ninety := 6.
    hundred := 7.
    thousand := 8.
    ((((one + two) + three) + four) + five) display.
    '
' display.
    hundred_and := 10.
    one_to_nine := ((((((((one + two) + three) + four) + five) + six) + seven) + eight) + nine).
    (one_to_nine) display.
    '
' display.
    one_to_ten := (one_to_nine + ten).
    one_to_twenty := ((((((((((one_to_ten + eleven) + twelve) + thirteen) + fourteen) + fifteen) + sixteen) + seventeen) + eighteen) + nineteen) + twenty).
    one_to_thirty := (((one_to_twenty + (twenty * 9)) + one_to_nine) + thirty).
    one_to_forty := (((one_to_thirty + (thirty * 9)) + one_to_nine) + forty).
    one_to_fifty := (((one_to_forty + (forty * 9)) + one_to_nine) + fifty).
    one_to_sixty := (((one_to_fifty + (fifty * 9)) + one_to_nine) + sixty).
    one_to_seventy := (((one_to_sixty + (sixty * 9)) + one_to_nine) + seventy).
    one_to_eighty := (((one_to_seventy + (seventy * 9)) + one_to_nine) + eighty).
    one_to_ninety := (((one_to_eighty + (eighty * 9)) + one_to_nine) + ninety).
    one_to_ninety_nine := ((one_to_ninety + (ninety * 9)) + one_to_nine).
    (one_to_ninety_nine) display.
    '
' display.
    ((((((100 * one_to_nine) + (one_to_ninety_nine * 10)) + ((hundred_and * 9) * 99)) + (hundred * 9)) + one) + thousand) display.
    '
' display.
    ]
]
Eval [ (euler17 new) main. ]

