Imports System

Module euler52

  Function chiffre_sort(ByVal a as Integer) As Integer
    If a < 10 Then
        Return a
    Else 
        Dim b As Integer = chiffre_sort(a \ 10)
        Dim c As Integer = a Mod 10
        Dim d As Integer = b Mod 10
        Dim e As Integer = b \ 10
        If c < d Then
            Return c + b * 10
        Else 
            Return d + chiffre_sort(c + e * 10) * 10
        End If
    End If
  End Function
  
  Function same_numbers(ByVal a as Integer, ByVal b as Integer, ByVal c as Integer, ByVal d as Integer, ByVal e as Integer, ByVal f as Integer) As Boolean
    Dim ca As Integer = chiffre_sort(a)
    Return ca = chiffre_sort(b) AndAlso ca = chiffre_sort(c) AndAlso ca = chiffre_sort(d) AndAlso ca = chiffre_sort(e) AndAlso ca = chiffre_sort(f)
  End Function
  
  Sub Main()
    Dim num As Integer = 142857
    If same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5) Then
        Console.Write(num & " " & (num * 2) & " " & (num * 3) & " " & (num * 4) & " " & (num * 5) & " " & (num * 6) & Chr(10))
    End If
  End Sub
  
End Module

