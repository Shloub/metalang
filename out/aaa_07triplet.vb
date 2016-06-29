Imports System
Imports System.Collections.Generic

Module aaa_07triplet

  
  Sub Main()
    For i As Integer = 1 To 3
        Dim d As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
        Dim a As Integer = d(0)
        Dim b As Integer = d(1)
        Dim c As Integer = d(2)
        Console.Write("a = " & a & " b = " & b & "c =" & c & Chr(10))
    Next
    Dim l As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For j As Integer = 0 To 9
        Console.Write(l(j) & Chr(10))
    Next
  End Sub
  
End Module

