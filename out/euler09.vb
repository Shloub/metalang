Imports System

Module euler09

  
  Sub Main()
    '
    '	a + b + c = 1000 && a * a + b * b = c * c
    '	
    
    For  a As Integer  = 1 to  1000
      For  b As Integer  = a + 1 to  1000
        Dim c As Integer = 1000 - a - b
        Dim a2b2 As Integer = a * a + b * b
        Dim cc As Integer = c * c
        If cc = a2b2 AndAlso c > a Then
          Console.Write(a)
          Console.Write(Chr(10))
          Console.Write(b)
          Console.Write(Chr(10))
          Console.Write(c)
          Console.Write(Chr(10))
          Console.Write(a * b * c)
          Console.Write(Chr(10))
        End If
      Next
    Next
  End Sub
  
End Module

