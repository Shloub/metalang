Imports System

Module test_enum

  Enum foo_t
    Foo
    Bar
    Blah
  End Enum
  
  
  Sub Main()
    Dim foo_val As foo_t = foo_t.Foo
  End Sub
  
End Module

