Imports System

Module aaa_01hello

  
  Sub Main()
    Console.Write("Hello World")
    Dim a As Integer = 5
    Console.Write(((4 + 6) * 2) & " " & Chr(10) & a & "foo")
    If 1 + (1 + 1) * 2 * (3 + 8) \ 4 - (1 - 2) - 3 = 12 AndAlso true Then
        Console.Write("True")
    Else 
        Console.Write("False")
    End If
    Console.Write(Chr(10))
    If (3 * (4 + 5 + 6) * 2 = 45) = false Then
        Console.Write("True")
    Else 
        Console.Write("False")
    End If
    Console.Write(" ")
    If (2 = 1) = false Then
        Console.Write("True")
    Else 
        Console.Write("False")
    End If
    Console.Write(" " & ((4 + 1) \ 3 \ (2 + 1)) & (4 * 1 \ 3 \ 2 * 1))
    If Not (Not (a = 0) AndAlso Not (a = 4)) Then
        Console.Write("True")
    Else 
        Console.Write("False")
    End If
    If true AndAlso Not false AndAlso Not (true AndAlso false) Then
        Console.Write("True")
    Else 
        Console.Write("False")
    End If
    Console.Write(Chr(10))
  End Sub
  
End Module

