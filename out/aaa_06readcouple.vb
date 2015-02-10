Imports System
Imports System.Collections.Generic

Module aaa_06readcouple

  
  Sub Main()
    For  i As Integer  = 1 to  3
      Dim h As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
      Dim a As Integer = h(0)
      Dim b As Integer = h(1)
      Console.Write("a = ")
      Console.Write(a)
      Console.Write(" b = ")
      Console.Write(b)
      Console.Write("" & Chr(10) & "")
    Next
    Dim l As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For  j As Integer  = 0 to  9
      Console.Write(l(j))
      Console.Write("" & Chr(10) & "")
    Next
  End Sub
  
End Module

