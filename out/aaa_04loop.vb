Imports System

Module aaa_04loop

  Function h(ByVal i as Integer) As Boolean
    '  for j = i - 2 to i + 2 do
    '    if i % j == 5 then return true end
    '  end 
    
    Dim j As Integer = i - 2
    Do While j <= i + 2
        If i Mod j = 5 Then
            Return true
        End If
        j = j + 1
    Loop
    Return false
  End Function
  Sub Main()
    Dim j As Integer = 0
    For k As Integer = 0 To 10
        j = j + k
        Console.Write(j & Chr(10))
    Next
    Dim i As Integer = 4
    Do While i < 10
        Console.Write(i)
        i = i + 1
        j = j + i
    Loop
    Console.Write(j & i & "FIN TEST" & Chr(10))
  End Sub
  
End Module

