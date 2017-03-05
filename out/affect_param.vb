Imports System

Module affect_param

  Sub foo(ByVal a as Integer)
    a = 4
  End Sub
  Sub Main()
    Dim a As Integer = 0
    foo(a)
    Console.Write(a & Chr(10))
  End Sub
  
End Module

