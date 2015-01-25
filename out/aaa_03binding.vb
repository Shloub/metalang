Imports System

Module aaa_03binding

  Function g(ByVal i as Integer) As Integer
    Dim j As Integer = i * 4
    If (j Mod 2) = 1 Then
      Return 0
    End If
    Return j
  End Function
  
  Sub h(ByVal i as Integer)
    Console.Write("" & i & "" & Chr(10) & "")
  End Sub
  
  
  Sub Main()
    h(14)
    Dim a As Integer = 4
    Dim b As Integer = 5
    Console.Write(a + b)
    ' main 
    
    h(15)
    a = 2
    b = 1
    Console.Write(a + b)
  End Sub
  
End Module

