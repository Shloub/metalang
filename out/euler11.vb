Imports System
Imports System.Collections.Generic

Module euler11

  Function find(ByVal n as Integer, ByRef m as Integer()(), ByVal x as Integer, ByVal y as Integer, ByVal dx as Integer, ByVal dy as Integer) As Integer
    If x < 0 OrElse x = 20 OrElse y < 0 OrElse y = 20 Then
      Return - 1
    ElseIf n = 0 Then
      Return 1
    Else
      Return m(y)(x) * find(n - 1, m, x + dx, y + dy, dx, dy)
    End If
  End Function
  
  Public Class tuple_int_int
    Public tuple_int_int_field_0 As Integer
    Public tuple_int_int_field_1 As Integer
  End Class
  
  Sub Main()
    Dim directions(8) As tuple_int_int
    For  i As Integer  = 0 to  8 - 1
      If i = 0 Then
        Dim ba As tuple_int_int = new tuple_int_int()
        ba.tuple_int_int_field_0 = 0
        ba.tuple_int_int_field_1 = 1
        directions(i) = ba
      ElseIf i = 1 Then
        Dim w As tuple_int_int = new tuple_int_int()
        w.tuple_int_int_field_0 = 1
        w.tuple_int_int_field_1 = 0
        directions(i) = w
      ElseIf i = 2 Then
        Dim v As tuple_int_int = new tuple_int_int()
        v.tuple_int_int_field_0 = 0
        v.tuple_int_int_field_1 = - 1
        directions(i) = v
      ElseIf i = 3 Then
        Dim u As tuple_int_int = new tuple_int_int()
        u.tuple_int_int_field_0 = - 1
        u.tuple_int_int_field_1 = 0
        directions(i) = u
      ElseIf i = 4 Then
        Dim t As tuple_int_int = new tuple_int_int()
        t.tuple_int_int_field_0 = 1
        t.tuple_int_int_field_1 = 1
        directions(i) = t
      ElseIf i = 5 Then
        Dim s As tuple_int_int = new tuple_int_int()
        s.tuple_int_int_field_0 = 1
        s.tuple_int_int_field_1 = - 1
        directions(i) = s
      ElseIf i = 6 Then
        Dim r As tuple_int_int = new tuple_int_int()
        r.tuple_int_int_field_0 = - 1
        r.tuple_int_int_field_1 = 1
        directions(i) = r
      Else
        Dim q As tuple_int_int = new tuple_int_int()
        q.tuple_int_int_field_0 = - 1
        q.tuple_int_int_field_1 = - 1
        directions(i) = q
      End If
    Next
    Dim max0 As Integer = 0
    Dim m(20)() As Integer
    For  h As Integer  = 0 to  20 - 1
      m(h) = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    Next
    For  j As Integer  = 0 to  7
      Dim p As tuple_int_int = directions(j)
      Dim dx As Integer = p.tuple_int_int_field_0
      Dim dy As Integer = p.tuple_int_int_field_1
      For  x As Integer  = 0 to  19
        For  y As Integer  = 0 to  19
          max0 = Math.Max(max0, find(4, m, x, y, dx, dy))
        Next
      Next
    Next
    Console.Write("" & max0 & "" & Chr(10) & "")
    End Sub
    
    End Module
    
    