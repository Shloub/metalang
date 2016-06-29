Imports System

Module sumDiv

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
  Sub foo()
    Dim a As Integer = 0
    ' test 
    
    a = a + 1
    ' test 2 
    
  End Sub
  
  Sub foo2()
    
  End Sub
  
  Sub foo3()
    If 1 = 1 Then
        
    End If
  End Sub
  
  Function sumdiv(ByVal n as Integer) As Integer
    ' On désire renvoyer la somme des diviseurs 
    
    Dim out0 As Integer = 0
    ' On déclare un entier qui contiendra la somme 
    
    For i As Integer = 1 To n
        ' La boucle : i est le diviseur potentiel
        
        If n Mod i = 0 Then
            ' Si i divise 
            
            out0 = out0 + i
            ' On incrémente 
            
        Else 
            ' nop 
            
        End If
    Next
    Return out0
    'On renvoie out
    
  End Function
  
  
  Sub Main()
    ' Programme principal 
    
    Dim n As Integer = 0
    n = readInt()
    ' Lecture de l'entier 
    
    Console.Write(sumdiv(n))
  End Sub
  
End Module

