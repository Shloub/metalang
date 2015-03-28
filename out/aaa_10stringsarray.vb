Imports System

Module aaa_10stringsarray

  '
  'TODO ajouter un record qui contient des chaines.
  '
  
  Function idstring(ByRef s as String) As String
    Return s
  End Function
  
  Sub printstring(ByRef s as String)
    Console.Write("" & idstring(s) & Chr(10))
  End Sub
  
  
  Sub Main()
    Dim tab(2) As String
    For  i As Integer  = 0 to  2 - 1
      tab(i) = idstring("chaine de test")
    Next
    For  j As Integer  = 0 to  1
      printstring(idstring(tab(j)))
    Next
    End Sub
    
  End Module
  
  