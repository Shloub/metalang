Imports System

Module euler17

  
  Sub Main()
    Dim one As Integer = 3
    Dim two As Integer = 3
    Dim three As Integer = 5
    Dim four As Integer = 4
    Dim five As Integer = 4
    Dim six As Integer = 3
    Dim seven As Integer = 5
    Dim eight As Integer = 5
    Dim nine As Integer = 4
    Dim ten As Integer = 3
    Dim eleven As Integer = 6
    Dim twelve As Integer = 6
    Dim thirteen As Integer = 8
    Dim fourteen As Integer = 8
    Dim fifteen As Integer = 7
    Dim sixteen As Integer = 7
    Dim seventeen As Integer = 9
    Dim eighteen As Integer = 8
    Dim nineteen As Integer = 8
    Dim twenty As Integer = 6
    Dim thirty As Integer = 6
    Dim forty As Integer = 5
    Dim fifty As Integer = 5
    Dim sixty As Integer = 5
    Dim seventy As Integer = 7
    Dim eighty As Integer = 6
    Dim ninety As Integer = 6
    Dim hundred As Integer = 7
    Dim thousand As Integer = 8
    Console.Write("" & (one + two + three + four + five) & "" & Chr(10) & "")
    Dim hundred_and As Integer = 10
    Dim one_to_nine As Integer = one + two + three + four + five + six + seven + eight + nine
    Console.Write("" & one_to_nine & "" & Chr(10) & "")
    Dim one_to_ten As Integer = one_to_nine + ten
    Dim one_to_twenty As Integer = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty
    Dim one_to_thirty As Integer = one_to_twenty + twenty * 9 + one_to_nine + thirty
    Dim one_to_forty As Integer = one_to_thirty + thirty * 9 + one_to_nine + forty
    Dim one_to_fifty As Integer = one_to_forty + forty * 9 + one_to_nine + fifty
    Dim one_to_sixty As Integer = one_to_fifty + fifty * 9 + one_to_nine + sixty
    Dim one_to_seventy As Integer = one_to_sixty + sixty * 9 + one_to_nine + seventy
    Dim one_to_eighty As Integer = one_to_seventy + seventy * 9 + one_to_nine + eighty
    Dim one_to_ninety As Integer = one_to_eighty + eighty * 9 + one_to_nine + ninety
    Dim one_to_ninety_nine As Integer = one_to_ninety + ninety * 9 + one_to_nine
    Console.Write("" & one_to_ninety_nine & "" & Chr(10) & "" & (100 * one_to_nine + one_to_ninety_nine * 10 + hundred_and * 9 * 99 + hundred * 9 + one + thousand) & "" & Chr(10) & "")
  End Sub
  
End Module

