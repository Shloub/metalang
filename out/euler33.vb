Imports System

Module euler33

  Function max2_(ByVal a as Integer, ByVal b as Integer) As Integer
    If a > b Then
      Return a
    Else
      Return b
    End If
  End Function
  
  Function min2_(ByVal a as Integer, ByVal b as Integer) As Integer
    If a < b Then
      Return a
    Else
      Return b
    End If
  End Function
  
  Function pgcd(ByVal a as Integer, ByVal b as Integer) As Integer
    Dim c As Integer = min2_(a, b)
    Dim d As Integer = max2_(a, b)
    Dim reste As Integer = d Mod c
    If reste = 0 Then
      Return c
    Else
      Return pgcd(c, reste)
    End If
  End Function
  
  
  Sub Main()
    Dim top As Integer = 1
    Dim bottom As Integer = 1
    For  i As Integer  = 1 to  9
      For  j As Integer  = 1 to  9
        For  k As Integer  = 1 to  9
          If i <> j AndAlso j <> k Then
            Dim a As Integer = i * 10 + j
            Dim b As Integer = j * 10 + k
            If a * k = i * b Then
              Console.Write(a)
              Console.Write("/")
              Console.Write(b)
              Console.Write("" & Chr(10) & "")
              top = top * a
              bottom = bottom * b
            End If
          End If
        Next
      Next
    Next
    Console.Write("" & top & "/" & bottom & "" & Chr(10) & "")
    Dim p As Integer = pgcd(top, bottom)
    Console.Write("" & "pgcd=" & p & "" & Chr(10) & "" & (bottom \ p) & "" & Chr(10) & "")
  End Sub
  
End Module

