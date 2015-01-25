Imports System

Module tuple

  Public Class tuple_int_int
    Public tuple_int_int_field_0 As Integer
    Public tuple_int_int_field_1 As Integer
  End Class
  Function f(ByRef tuple0 as tuple_int_int) As tuple_int_int
    Dim c As tuple_int_int = tuple0
    Dim a As Integer = c.tuple_int_int_field_0
    Dim b As Integer = c.tuple_int_int_field_1
    Dim e As tuple_int_int = new tuple_int_int()
    e.tuple_int_int_field_0 = a + 1
    e.tuple_int_int_field_1 = b + 1
    Return e
  End Function
  
  
  Sub Main()
    Dim g As tuple_int_int = new tuple_int_int()
    g.tuple_int_int_field_0 = 0
    g.tuple_int_int_field_1 = 1
    Dim t As tuple_int_int = f(g)
    Dim d As tuple_int_int = t
    Dim a As Integer = d.tuple_int_int_field_0
    Dim b As Integer = d.tuple_int_int_field_1
    Console.Write("" & a & " -- " & b & "--" & Chr(10) & "")
  End Sub
  
End Module

