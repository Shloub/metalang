Imports System

Module euler01

  
  Sub Main()
    Dim sum As Integer = 0
    For i As Integer = 0 To 999
        If i Mod 3 = 0 OrElse i Mod 5 = 0 Then
            sum = sum + i
        End If
    Next
    Console.Write(sum & Chr(10))
  End Sub
  
End Module

