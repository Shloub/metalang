Imports System

Module euler22

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
  Function score() As Integer
    stdin_sep()
    Dim len As Integer = readInt()
    stdin_sep()
    Dim sum As Integer = 0
    For  i As Integer  = 1 to  len
      Dim c As Char = readChar()
      sum = sum + (Asc(c) - Asc("A"C)) + 1
      '		print c print " " print sum print " " 
      
    Next
    Return sum
  End Function
  
  
  Sub Main()
    Dim sum As Integer = 0
    Dim n As Integer = readInt()
    For  i As Integer  = 1 to  n
      sum = sum + i * score()
    Next
    Console.Write("" & sum & "" & Chr(10) & "")
  End Sub
  
End Module

