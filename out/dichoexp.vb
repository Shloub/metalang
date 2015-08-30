Imports System

Module dichoexp

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
  Function exp0(ByVal a as Integer, ByVal b as Integer) As Integer
    If b = 0 Then
      Return 1
    End If
    If b Mod 2 = 0 Then
      Dim o As Integer = exp0(a, b \ 2)
      Return o * o
    Else
      Return a * exp0(a, b - 1)
    End If
  End Function
  
  
  Sub Main()
    Dim a As Integer = 0
    Dim b As Integer = 0
    a = readInt()
    stdin_sep()
    b = readInt()
    Console.Write(exp0(a, b))
  End Sub
  
End Module

