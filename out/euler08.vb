Imports System

Module euler08

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
Function readChar() As Char
  Dim out_ as Char = readChar_()
  consommeChar()
  Return out_
End Function
  Function max2_(ByVal a as Integer, ByVal b as Integer) As Integer
    If a > b Then
      Return a
    Else
      Return b
    End If
  End Function
  
  
  Sub Main()
    Dim i As Integer = 1
    Dim last(5) As Integer
    For  j As Integer  = 0 to  5 - 1
      Dim c As Char = readChar()
      Dim d As Integer = Asc(c) - Asc("0"C)
      i = i * d
      last(j) = d
    Next
    Dim max0 As Integer = i
    Dim index As Integer = 0
    Dim nskipdiv As Integer = 0
    For  k As Integer  = 1 to  995
      Dim e As Char = readChar()
      Dim f As Integer = Asc(e) - Asc("0"C)
      If f = 0 Then
        i = 1
        nskipdiv = 4
      Else
        i = i * f
        If nskipdiv < 0 Then
          i = i \ last(index)
        End If
        nskipdiv = nskipdiv - 1
      End If
      last(index) = f
      index = (index + 1) Mod 5
      max0 = max2_(max0, i)
    Next
    Console.Write("" & max0 & "" & Chr(10) & "")
    End Sub
    
  End Module
  
  