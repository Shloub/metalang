Imports System

Module euler40

  Function exp0(ByVal a as Integer, ByVal e as Integer) As Integer
    Dim o As Integer = 1
    For  i As Integer  = 1 to  e
      o = o * a
    Next
    Return o
  End Function
  
  Function e(ByRef t as Integer(), ByVal n as Integer) As Integer
    For  i As Integer  = 1 to  8
      If n >= t(i) * i Then
        n = n - t(i) * i
      Else
        Dim nombre As Integer = exp0(10, i - 1) + n \ i
        Dim chiffre As Integer = i - 1 - n Mod i
        Return (nombre \ exp0(10, chiffre)) Mod 10
      End If
    Next
    Return - 1
  End Function
  
  
  Sub Main()
    Dim t(9) As Integer
    For  i As Integer  = 0 to  9 - 1
      t(i) = exp0(10, i) - exp0(10, i - 1)
    Next
    For  i2 As Integer  = 1 to  8
      Console.Write(i2)
      Console.Write(" => ")
      Console.Write(t(i2))
      Console.Write(Chr(10))
    Next
    For  j As Integer  = 0 to  80
      Console.Write(e(t, j))
    Next
    Console.Write(Chr(10))
    For  k As Integer  = 1 to  50
      Console.Write(k)
    Next
    Console.Write(Chr(10))
    For  j2 As Integer  = 169 to  220
      Console.Write(e(t, j2))
    Next
    Console.Write(Chr(10))
    For  k2 As Integer  = 90 to  110
      Console.Write(k2)
    Next
    Console.Write(Chr(10))
    Dim out0 As Integer = 1
    For  l As Integer  = 0 to  6
      Dim puiss As Integer = exp0(10, l)
      Dim v As Integer = e(t, puiss - 1)
      out0 = out0 * v
      Console.Write("10^")
      Console.Write(l)
      Console.Write("=")
      Console.Write(puiss)
      Console.Write(" v=")
      Console.Write(v)
      Console.Write(Chr(10))
    Next
    Console.Write("" & out0 & Chr(10))
    End Sub
    
  End Module
  
  