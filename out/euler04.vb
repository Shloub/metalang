Imports System

Module euler04

  '
  '
  '(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
  'a * d + a * e * 10 + a * f * 100 +
  '10 * (b * d + b * e * 10 + b * f * 100)+
  '100 * (c * d + c * e * 10 + c * f * 100) =
  '
  'a * d       + a * e * 10   + a * f * 100 +
  'b * d * 10  + b * e * 100  + b * f * 1000 +
  'c * d * 100 + c * e * 1000 + c * f * 10000 =
  '
  'a * d +
  '10 * ( a * e + b * d) +
  '100 * (a * f + b * e + c * d) +
  '(c * e + b * f) * 1000 +
  'c * f * 10000
  '
  '
  
  Function chiffre(ByVal c as Integer, ByVal m as Integer) As Integer
    If c = 0 Then
        Return m Mod 10
    Else 
        Return chiffre(c - 1, m \ 10)
    End If
  End Function
  
  
  Sub Main()
    Dim m As Integer = 1
    For a As Integer = 0 To 9
        For f As Integer = 1 To 9
            For d As Integer = 0 To 9
                For c As Integer = 1 To 9
                    For b As Integer = 0 To 9
                        For e As Integer = 0 To 9
                            Dim mul As Integer = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f
                            If chiffre(0, mul) = chiffre(5, mul) AndAlso chiffre(1, mul) = chiffre(4, mul) AndAlso chiffre(2, mul) = chiffre(3, mul) Then
                                m = Math.Max(mul, m)
                            End If
                        Next
                    Next
                Next
            Next
        Next
    Next
    Console.Write(m & Chr(10))
  End Sub
  
End Module

