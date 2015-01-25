Imports System

Module aaa_read2

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
  '
  'Ce test permet de vérifier si les différents backends pour les langages implémentent bien
  'read int, read char et skip
  '
  
  
  Sub Main()
    Dim b As Integer = readInt()
    stdin_sep()
    Dim len As Integer = b
    Console.Write("" & len & "=len" & Chr(10) & "")
    Dim tab(len) As Integer
    For  f As Integer  = 0 to  len - 1
      tab(f) = readInt()
      stdin_sep()
    Next
    For  i As Integer  = 0 to  len - 1
      Console.Write(i)
      Console.Write("=>")
      Console.Write(tab(i))
      Console.Write(" ")
    Next
    Console.Write("" & Chr(10) & "")
    Dim tab2(len) As Integer
    For  l As Integer  = 0 to  len - 1
      tab2(l) = readInt()
      stdin_sep()
    Next
    For  i_ As Integer  = 0 to  len - 1
      Console.Write(i_)
      Console.Write("==>")
      Console.Write(tab2(i_))
      Console.Write(" ")
    Next
    Dim p As Integer = readInt()
    stdin_sep()
    Dim strlen As Integer = p
    Console.Write("" & strlen & "=strlen" & Chr(10) & "")
    Dim tab4(strlen) As Char
    For  s As Integer  = 0 to  strlen - 1
      tab4(s) = readChar()
    Next
    stdin_sep()
    For  i3 As Integer  = 0 to  strlen - 1
      Dim tmpc As Char = tab4(i3)
      Dim c As Integer = Asc(tmpc)
      Console.Write(tmpc)
      Console.Write(":")
      Console.Write(c)
      Console.Write(" ")
      If tmpc <> Chr(32) Then
        c = ((c - Asc("a"C)) + 13) Mod 26 + Asc("a"C)
      End If
      tab4(i3) = Chr(c)
    Next
    For  j As Integer  = 0 to  strlen - 1
      Console.Write(tab4(j))
    Next
    End Sub
    
    End Module
     