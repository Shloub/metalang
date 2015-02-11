Imports System

Module loop_unroll

  '
  'Ce test permet de vérifier le comportement des macros
  'Il effectue du loop unrolling
  '
  
  
  Sub Main()
    Dim j As Integer = 0
    j = 0
    Console.Write("" & j & Chr(10))
    j = 1
    Console.Write("" & j & Chr(10))
    j = 2
    Console.Write("" & j & Chr(10))
    j = 3
    Console.Write("" & j & Chr(10))
    j = 4
    Console.Write("" & j & Chr(10))
  End Sub
  
End Module

