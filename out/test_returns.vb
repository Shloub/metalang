Imports System

Module test_returns

  Function is_pair(ByVal i as Integer) As Boolean
    Dim j As Integer = 1
    If i < 10 Then
        j = 2
        If i = 0 Then
            j = 4
            Return true
        End If
        j = 3
        If i = 2 Then
            j = 4
            Return true
        End If
        j = 5
    End If
    j = 6
    If i < 20 Then
        If i = 22 Then
            j = 0
        End If
        j = 8
    End If
    Return i Mod 2 = 0
  End Function
  
  Sub Main()
    
  End Sub
  
End Module

