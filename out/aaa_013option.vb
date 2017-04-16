Imports System

Module aaa_013option

  Public Class foo
    Public a As Integer
    Public b As Integer?
    Public c As Integer()
    Public d As Integer?()
    Public e As Integer()
    Public f As foo
    Public g As foo()
    Public h As foo()
  End Class
  Function default0(ByRef a as Integer?, ByRef b as foo, ByRef c as Integer?(), ByRef d as foo(), ByRef e as Integer(), ByRef f as foo()) As Integer
    Return 0
  End Function
  Sub aa(ByRef b as foo)
    
  End Sub
  Sub Main()
    Console.Write("___" & Chr(10))
  End Sub
  
End Module

