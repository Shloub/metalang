Imports System

Module euler39

  
  Sub Main()
    Dim t(1001) As Integer
    For  i As Integer  = 0 to  1001 - 1
      t(i) = 0
    Next
    For  a As Integer  = 1 to  1000
      For  b As Integer  = 1 to  1000
        Dim c2 As Integer = a * a + b * b
        Dim c As Integer = Int(Math.Sqrt(c2))
        If c * c = c2 Then
          Dim p As Integer = a + b + c
          If p <= 1000 Then
            t(p) = t(p) + 1
          End If
        End If
      Next
    Next
    Dim j As Integer = 0
    For  k As Integer  = 1 to  1000
      If t(k) > t(j) Then
        j = k
      End If
    Next
    Console.Write(j)
    End Sub
    
  End Module
  
  