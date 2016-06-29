Imports System

Module euler09

  
  Sub Main()
    '
    '	a + b + c = 1000 && a * a + b * b = c * c
    '	
    
    For a As Integer = 1 To 1000
        For b As Integer = a + 1 To 1000
            Dim c As Integer = 1000 - a - b
            Dim a2b2 As Integer = a * a + b * b
            Dim cc As Integer = c * c
            If cc = a2b2 AndAlso c > a Then
                Console.Write(a & Chr(10) & b & Chr(10) & c & Chr(10) & (a * b * c) & Chr(10))
            End If
        Next
    Next
  End Sub
  
End Module

