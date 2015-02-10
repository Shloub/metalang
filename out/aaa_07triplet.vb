Imports System
Imports System.Collections.Generic

Module aaa_07triplet

  
  Sub Main()
    For  i As Integer  = 1 to  3
      Dim k As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
      Dim a As Integer = k(0)
      Dim b As Integer = k(1)
      Dim c As Integer = k(2)
      Console.Write("a = ")
      Console.Write(a)
      Console.Write(" b = ")
      Console.Write(b)
      Console.Write("c =")
      Console.Write(c)
      Console.Write("" & Chr(10) & "")
    Next
    Dim l As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For  j As Integer  = 0 to  9
      Console.Write(l(j))
      Console.Write("" & Chr(10) & "")
    Next
  End Sub
  
End Module

