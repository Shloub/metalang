Imports System

Module euler45

  Function triangle(ByVal n as Integer) As Integer
    If n Mod 2 = 0 Then
        Return (n \ 2) * (n + 1)
    Else 
        Return n * ((n + 1) \ 2)
    End If
  End Function
  
  Function penta(ByVal n as Integer) As Integer
    If n Mod 2 = 0 Then
        Return (n \ 2) * (3 * n - 1)
    Else 
        Return ((3 * n - 1) \ 2) * n
    End If
  End Function
  
  Function hexa(ByVal n as Integer) As Integer
    Return n * (2 * n - 1)
  End Function
  
  Function findPenta2(ByVal n as Integer, ByVal a as Integer, ByVal b as Integer) As Boolean
    If b = a + 1 Then
        Return penta(a) = n OrElse penta(b) = n
    End If
    Dim c As Integer = (a + b) \ 2
    Dim p As Integer = penta(c)
    If p = n Then
        Return true
    ElseIf p < n Then
        Return findPenta2(n, c, b)
    Else 
        Return findPenta2(n, a, c)
    End If
  End Function
  
  Function findHexa2(ByVal n as Integer, ByVal a as Integer, ByVal b as Integer) As Boolean
    If b = a + 1 Then
        Return hexa(a) = n OrElse hexa(b) = n
    End If
    Dim c As Integer = (a + b) \ 2
    Dim p As Integer = hexa(c)
    If p = n Then
        Return true
    ElseIf p < n Then
        Return findHexa2(n, c, b)
    Else 
        Return findHexa2(n, a, c)
    End If
  End Function
  
  Sub Main()
    For n As Integer = 285 To 55385
        Dim t As Integer = triangle(n)
        If findPenta2(t, n \ 5, n) AndAlso findHexa2(t, n \ 5, n \ 2 + 10) Then
            Console.Write(n & Chr(10) & t & Chr(10))
        End If
    Next
  End Sub
  
End Module

