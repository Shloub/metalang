Imports System

Module aaa_07triplet

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
  
  Sub Main()
    For  i As Integer  = 1 to  3
      Dim a As Integer = readInt()
      stdin_sep()
      Dim b As Integer = readInt()
      stdin_sep()
      Dim c As Integer = readInt()
      stdin_sep()
      Console.Write("a = ")
      Console.Write(a)
      Console.Write(" b = ")
      Console.Write(b)
      Console.Write("c =")
      Console.Write(c)
      Console.Write("" & Chr(10) & "")
    Next
  End Sub
  
End Module

