Imports System

Module euler02

  
  Sub Main()
    Dim a As Integer = 1
    Dim b As Integer = 2
    Dim sum As Integer = 0
    Do While a < 4000000
      If (a Mod 2) = 0 Then
        sum = sum + a
      End If
      Dim c As Integer = a
      a = b
      b = b + c
    Loop
    Console.Write("" & sum & "" & Chr(10) & "")
  End Sub
  
End Module

