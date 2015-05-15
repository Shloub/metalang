Imports System

Module aaa_01hello

  
  Sub Main()
    Console.Write("Hello World")
    Dim a As Integer = 5
    Console.Write("" & ((4 + 6) * 2) & " " & Chr(10) & a & "foo")
    Dim b As Boolean = 1 + (1 + 1) * 2 * (3 + 8) \ 4 - (1 - 2) - 3 = 12 AndAlso true
    If b Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write(Chr(10))
    Dim c As Boolean = (3 * (4 + 5 + 6) * 2 = 45) = false
    If c Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write(" ")
    Dim d As Boolean = (2 = 1) = false
    If d Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write(" " & ((4 + 1) \ 3 \ (2 + 1)) & (4 * 1 \ 3 \ 2 * 1))
    Dim e As Boolean = Not (Not (a = 0) AndAlso Not (a = 4))
    If e Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Dim f As Boolean = true AndAlso Not false AndAlso Not (true AndAlso false)
    If f Then
      Console.Write("True")
    Else
      Console.Write("False")
    End If
    Console.Write(Chr(10))
  End Sub
  
End Module

