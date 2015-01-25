Imports System

Module aaa_05array

  Function id(ByRef b as Boolean()) As Boolean()
    Return b
  End Function
  
  Sub g(ByRef t as Boolean(), ByVal index as Integer)
    t(index) = false
  End Sub
  
  
  Sub Main()
    Dim a(5) As Boolean
    For  i As Integer  = 0 to  5 - 1
      Console.Write(i)
      a(i) = (i Mod 2) = 0
    Next
    Dim c As Boolean = a(0)
    If c Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write("" & Chr(10) & "")
    g(id(a), 0)
    Dim d As Boolean = a(0)
    If d Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write("" & Chr(10) & "")
    End Sub
    
  End Module
  
  