Imports System

Module aaa_missing

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
  '
  '  Ce test a été généré par Metalang.
  '
  
  Function result(ByVal len as Integer, ByRef tab as Integer()) As Integer
    Dim tab2(len) As Boolean
    For  i As Integer  = 0 to  len - 1
      tab2(i) = false
    Next
    For  i1 As Integer  = 0 to  len - 1
      Console.Write(tab(i1))
      Console.Write(" ")
      tab2(tab(i1)) = true
    Next
    Console.Write("" & Chr(10) & "")
    For  i2 As Integer  = 0 to  len - 1
      If Not tab2(i2) Then
        Return i2
      End If
    Next
    Return - 1
    End Function
    
    
    Sub Main()
      Dim b As Integer = readInt()
      stdin_sep()
      Dim len As Integer = b
      Console.Write("" & len & "" & Chr(10) & "")
      Dim tab(len) As Integer
      For  e As Integer  = 0 to  len - 1
        tab(e) = readInt()
        stdin_sep()
      Next
      Console.Write("" & result(len, tab) & "" & Chr(10) & "")
      End Sub
      
    End Module
    
    