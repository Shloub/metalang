Imports System

Module prologin_template_charmatrix

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
  Function programme_candidat(ByRef tableau as Char()(), ByVal taille_x as Integer, ByVal taille_y as Integer) As Integer
    Dim out0 As Integer = 0
    For  i As Integer  = 0 to  taille_y - 1
      For  j As Integer  = 0 to  taille_x - 1
        out0 = out0 + Asc(tableau(i)(j)) * (i + j * 2)
        Console.Write(tableau(i)(j))
      Next
      Console.Write("--" & Chr(10) & "")
    Next
    Return out0
  End Function
  
  
  Sub Main()
    Dim taille_x As Integer = readInt()
    stdin_sep()
    Dim taille_y As Integer = readInt()
    stdin_sep()
    Dim l(taille_y)() As Char
    For  m As Integer  = 0 to  taille_y - 1
      Dim r(taille_x) As Char
      For  p As Integer  = 0 to  taille_x - 1
        r(p) = readChar()
      Next
      stdin_sep()
      l(m) = r
      Next
      Dim tableau As Char()() = l
      Console.Write("" & programme_candidat(tableau, taille_x, taille_y) & "" & Chr(10) & "")
    End Sub
    
    End Module
    
    