Imports System
Imports System.Collections.Generic

Module aaa_08tuple

  Public Class tuple_int_int
    Public tuple_int_int_field_0 As Integer
    Public tuple_int_int_field_1 As Integer
  End Class
  Public Class toto
    Public foo As tuple_int_int
    Public bar As Integer
  End Class
  
  Sub Main()
    Dim bar_ As Integer = Integer.Parse(Console.ReadLine())
    Dim c As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    Dim d As tuple_int_int = new tuple_int_int()
    d.tuple_int_int_field_0 = c(0)
    d.tuple_int_int_field_1 = c(1)
    Dim t As toto = new toto()
    t.foo = d
    t.bar = bar_
    Dim e As tuple_int_int = t.foo
    Dim a As Integer = e.tuple_int_int_field_0
    Dim b As Integer = e.tuple_int_int_field_1
    Console.Write(a & " " & b & " " & t.bar & Chr(10))
  End Sub
  
End Module

