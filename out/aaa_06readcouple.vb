Imports System
Imports System.Collections.Generic

Module aaa_06readcouple

  
  Sub Main()
    For i As Integer = 1 To 3
        Dim c As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
        Dim a As Integer = c(0)
        Dim b As Integer = c(1)
        Console.Write("a = " & a & " b = " & b & Chr(10))
    Next
    Dim l As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For j As Integer = 0 To 9
        Console.Write(l(j) & Chr(10))
    Next
  End Sub
  
End Module

