Imports System

Module record2

Dim eof As Boolean
Dim buffer As String
Function readChar_() As Char
  If buffer Is Nothing OrElse buffer.Length = 0 Then
    Dim tmp As String = Console.ReadLine()
    eof = (tmp Is Nothing)
    buffer = tmp + Chr(10)
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
  Public Class toto
    Public foo As Integer
    Public bar As Integer
    Public blah As Integer
  End Class
  Function mktoto(ByVal v1 as Integer) As toto
    Dim t As toto = new toto()
    t.foo = v1
    t.bar = 0
    t.blah = 0
    Return t
  End Function
  Function result(ByRef t as toto) As Integer
    t.blah = t.blah + 1
    Return t.foo + t.blah * t.bar + t.bar * t.foo
  End Function
  Sub Main()
    Dim t As toto = mktoto(4)
    t.bar = readInt
    stdin_sep
    t.blah = readInt
    Console.Write(result(t))
  End Sub
  
End Module

