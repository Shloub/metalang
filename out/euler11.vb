Imports System

Module euler11

Dim eof As Boolean
Dim buffer As String
Function readChar_() As Char
  If buffer Is Nothing Then
    buffer = Console.ReadLine()
  End If
  If buffer.Length = 0 Then
    Dim tmp As String = Console.ReadLine()
    eof = (tmp Is Nothing)
    buffer = Chr(10)+tmp
  End If
  Return buffer(0)
End Function

Sub consommeChar()
  readChar_()
  buffer = buffer.Substring(1)
End Sub

Sub stdin_sep()
  Do
    If eof Then
      Return
    End If
    Dim c As Char = readChar_()
    If c = " "C Or c = Chr(13) Or c = Chr(9) Or c = Chr(10) Then
      consommeChar()
    Else
      Return
    End If
  Loop
End Sub

Function readInt() As Integer
  Dim i As Integer = 0
  Dim s as Char = readChar_()
  Dim sign As Integer = 1
  If s = "-"C Then
    sign = -1
    consommeChar()
  End If
  Do
    Dim c as Char = readChar_()
    If c <= "9"C And c >= "0"C Then
      i = i * 10 + Asc(c) - Asc("0"C)
      consommeChar()
    Else
      return i * sign
    End If
  Loop
End Function
  Function max2_(ByVal a as Integer, ByVal b as Integer) As Integer
    If a > b Then
      Return a
    Else
      Return b
    End If
  End Function
  
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
        Dim bh As tuple_int_int = new tuple_int_int()
        bh.tuple_int_int_field_0 = 0
        bh.tuple_int_int_field_1 = 1
        directions(i) = bh
      ElseIf i = 1 Then
        Dim bg As tuple_int_int = new tuple_int_int()
        bg.tuple_int_int_field_0 = 1
        bg.tuple_int_int_field_1 = 0
        directions(i) = bg
      ElseIf i = 2 Then
        Dim bf As tuple_int_int = new tuple_int_int()
        bf.tuple_int_int_field_0 = 0
        bf.tuple_int_int_field_1 = - 1
        directions(i) = bf
      ElseIf i = 3 Then
        Dim be As tuple_int_int = new tuple_int_int()
        be.tuple_int_int_field_0 = - 1
        be.tuple_int_int_field_1 = 0
        directions(i) = be
      ElseIf i = 4 Then
        Dim bd As tuple_int_int = new tuple_int_int()
        bd.tuple_int_int_field_0 = 1
        bd.tuple_int_int_field_1 = 1
        directions(i) = bd
      ElseIf i = 5 Then
        Dim bc As tuple_int_int = new tuple_int_int()
        bc.tuple_int_int_field_0 = 1
        bc.tuple_int_int_field_1 = - 1
        directions(i) = bc
      ElseIf i = 6 Then
        Dim bb As tuple_int_int = new tuple_int_int()
        bb.tuple_int_int_field_0 = - 1
        bb.tuple_int_int_field_1 = 1
        directions(i) = bb
      Else
        Dim ba As tuple_int_int = new tuple_int_int()
        ba.tuple_int_int_field_0 = - 1
        ba.tuple_int_int_field_1 = - 1
        directions(i) = ba
      End If
    Next
    Dim max0 As Integer = 0
    Dim h As Integer = 20
    Dim m(20)() As Integer
    For  o As Integer  = 0 to  20 - 1
      Dim s(h) As Integer
      For  q As Integer  = 0 to  h - 1
        s(q) = readInt()
        stdin_sep()
      Next
      m(o) = s
      Next
      For  j As Integer  = 0 to  7
        Dim w As tuple_int_int = directions(j)
        Dim dx As Integer = w.tuple_int_int_field_0
        Dim dy As Integer = w.tuple_int_int_field_1
        For  x As Integer  = 0 to  19
          For  y As Integer  = 0 to  19
            max0 = max2_(max0, find(4, m, x, y, dx, dy))
          Next
        Next
      Next
      Console.Write("" & max0 & "" & Chr(10) & "")
    End Sub
    
    End Module
     