Imports System

Module euler17

  
  Sub Main()
    Console.Write((3 + 16) & Chr(10))
    Dim one_to_nine As Integer = 3 + 33
    Console.Write(one_to_nine & Chr(10))
    Dim one_to_ten As Integer = one_to_nine + 3
    Dim one_to_twenty As Integer = one_to_ten + 73
    Dim one_to_thirty As Integer = one_to_twenty + 6 * 9 + one_to_nine + 6
    Dim one_to_forty As Integer = one_to_thirty + 6 * 9 + one_to_nine + 5
    Dim one_to_fifty As Integer = one_to_forty + 5 * 9 + one_to_nine + 5
    Dim one_to_sixty As Integer = one_to_fifty + 5 * 9 + one_to_nine + 5
    Dim one_to_seventy As Integer = one_to_sixty + 5 * 9 + one_to_nine + 7
    Dim one_to_eighty As Integer = one_to_seventy + 7 * 9 + one_to_nine + 6
    Dim one_to_ninety As Integer = one_to_eighty + 6 * 9 + one_to_nine + 6
    Dim one_to_ninety_nine As Integer = one_to_ninety + 6 * 9 + one_to_nine
    Console.Write(one_to_ninety_nine & Chr(10) & (100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11) & Chr(10))
  End Sub
  
End Module

