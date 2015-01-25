Imports System

Module min4

  Function min2_(ByVal a as Integer, ByVal b as Integer) As Integer
    If a < b Then
      Return a
    Else
      Return b
    End If
  End Function
  
  
  Sub Main()
    Console.Write("" & min2_(min2_(min2_(1, 2), 3), 4) & " " & min2_(min2_(min2_(1, 2), 4), 3) & " " & min2_(min2_(min2_(1, 3), 2), 4) & " " & min2_(min2_(min2_(1, 3), 4), 2) & " " & min2_(min2_(min2_(1, 4), 2), 3) & " " & min2_(min2_(min2_(1, 4), 3), 2) & "" & Chr(10) & "" & min2_(min2_(min2_(2, 1), 3), 4) & " " & min2_(min2_(min2_(2, 1), 4), 3) & " " & min2_(min2_(min2_(2, 3), 1), 4) & " " & min2_(min2_(min2_(2, 3), 4), 1) & " " & min2_(min2_(min2_(2, 4), 1), 3) & " " & min2_(min2_(min2_(2, 4), 3), 1) & "" & Chr(10) & "" & min2_(min2_(min2_(3, 1), 2), 4) & " " & min2_(min2_(min2_(3, 1), 4), 2) & " " & min2_(min2_(min2_(3, 2), 1), 4) & " " & min2_(min2_(min2_(3, 2), 4), 1) & " " & min2_(min2_(min2_(3, 4), 1), 2) & " " & min2_(min2_(min2_(3, 4), 2), 1) & "" & Chr(10) & "" & min2_(min2_(min2_(4, 1), 2), 3) & " " & min2_(min2_(min2_(4, 1), 3), 2) & " " & min2_(min2_(min2_(4, 2), 1), 3) & " " & min2_(min2_(min2_(4, 2), 3), 1) & " " & min2_(min2_(min2_(4, 3), 1), 2) & " " & min2_(min2_(min2_(4, 3), 2), 1) & "" & Chr(10) & "")
  End Sub
  
End Module

