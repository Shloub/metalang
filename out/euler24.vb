Imports System

Module euler24

  Function fact(ByVal n as Integer) As Integer
    Dim prod As Integer = 1
    For  i As Integer  = 2 to  n
      prod = prod * i
    Next
    Return prod
  End Function
  
  Sub show(ByVal lim as Integer, ByVal nth as Integer)
    Dim t(lim) As Integer
    For  i As Integer  = 0 to  lim - 1
      t(i) = i
    Next
    Dim pris(lim) As Boolean
    For  j As Integer  = 0 to  lim - 1
      pris(j) = false
    Next
    For  k As Integer  = 1 to  lim - 1
      Dim n As Integer = fact(lim - k)
      Dim nchiffre As Integer = nth \ n
      nth = nth Mod n
      For  l As Integer  = 0 to  lim - 1
        If Not pris(l) Then
          If nchiffre = 0 Then
            Console.Write(l)
            pris(l) = true
          End If
          nchiffre = nchiffre - 1
        End If
      Next
    Next
    For  m As Integer  = 0 to  lim - 1
      If Not pris(m) Then
        Console.Write(m)
      End If
    Next
    Console.Write(Chr(10))
    End Sub
    
    
    Sub Main()
      show(10, 999999)
    End Sub
    
    End Module
    
    