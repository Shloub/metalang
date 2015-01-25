Imports System

Module aaa_readints

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
    Dim f As Integer = readInt()
    stdin_sep()
    Dim len As Integer = f
    Console.Write("" & len & "=len" & Chr(10) & "")
    Dim tab1(len) As Integer
    For  k As Integer  = 0 to  len - 1
      tab1(k) = readInt()
      stdin_sep()
    Next
    For  i As Integer  = 0 to  len - 1
      Console.Write(i)
      Console.Write("=>")
      Console.Write(tab1(i))
      Console.Write("" & Chr(10) & "")
    Next
    len = readInt()
    stdin_sep()
    Dim tab2(len - 1)() As Integer
    For  s As Integer  = 0 to  len - 1 - 1
      Dim ba(len) As Integer
      For  v As Integer  = 0 to  len - 1
        Dim w As Integer = readInt()
        stdin_sep()
        ba(v) = w
      Next
      tab2(s) = ba
      Next
      For  i As Integer  = 0 to  len - 2
        For  j As Integer  = 0 to  len - 1
          Console.Write(tab2(i)(j))
          Console.Write(" ")
        Next
        Console.Write("" & Chr(10) & "")
      Next
    End Sub
    
    End Module
     