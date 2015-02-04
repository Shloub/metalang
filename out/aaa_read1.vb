Imports System
Imports System.Collections.Generic

Module aaa_read1

  
  Sub Main()
    Dim str As Char() = Console.ReadLine().ToCharArray()
    For  i As Integer  = 0 to  11
      Console.Write(str(i))
    Next
  End Sub
  
End Module

