Imports System

Module calc

  '
  'La suite de fibonaci
  '
  
  Function fibo(ByVal a as Integer, ByVal b as Integer, ByVal i as Integer) As Integer
    Dim out_ As Integer = 0
    Dim a2 As Integer = a
    Dim b2 As Integer = b
    For j As Integer = 0 To i + 1
        Console.Write(j)
        out_ = out_ + a2
        Dim tmp As Integer = b2
        b2 = b2 + a2
        a2 = tmp
    Next
    Return out_
  End Function
  Sub Main()
    Console.Write(fibo(1, 2, 4))
  End Sub
  
End Module

