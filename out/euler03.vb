Imports System

Module euler03

  
  Sub Main()
    Dim maximum As Integer = 1
    Dim b0 As Integer = 2
    Dim a As Integer = 408464633
    Dim sqrtia As Integer = Int(Math.Sqrt(a))
    Do While a <> 1
        Dim b As Integer = b0
        Dim found As Boolean = false
        Do While b <= sqrtia
            If a Mod b = 0 Then
                a = a \ b
                b0 = b
                b = a
                sqrtia = Int(Math.Sqrt(a))
                found = true
            End If
            b = b + 1
        Loop
        If Not found Then
            Console.Write(a & Chr(10))
            a = 1
        End If
    Loop
  End Sub
  
End Module

