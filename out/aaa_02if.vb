Imports System

Module aaa_02if

  Function f(ByVal i as Integer) As Boolean
    If i = 0 Then
        Return true
    End If
    Return false
  End Function
  
  Sub Main()
    If f(4) Then
        Console.Write("true <-" & Chr(10) & " ->" & Chr(10))
    Else 
        Console.Write("false <-" & Chr(10) & " ->" & Chr(10))
    End If
    Console.Write("small test end" & Chr(10))
  End Sub
  
End Module

