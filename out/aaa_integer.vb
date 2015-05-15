Imports System

Module aaa_integer

  
  Sub Main()
    Dim i As Integer = 0
    i = i - 1
    Console.Write("" & i & Chr(10))
    i = i + 55
    Console.Write("" & i & Chr(10))
    i = i * 13
    Console.Write("" & i & Chr(10))
    i = i \ 2
    Console.Write("" & i & Chr(10))
    i = i + 1
    Console.Write("" & i & Chr(10))
    i = i \ 3
    Console.Write("" & i & Chr(10))
    i = i - 1
    Console.Write("" & i & Chr(10))
    '
    'http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
    '
    
    Console.Write("" & (117 \ 17) & Chr(10) & (117 \ -17) & Chr(10) & (-117 \ 17) & Chr(10) & (-117 \ -17) & Chr(10) & (117 Mod 17) & Chr(10) & (117 Mod -17) & Chr(10) & (-117 Mod 17) & Chr(10) & (-117 Mod -17) & Chr(10))
  End Sub
  
End Module

