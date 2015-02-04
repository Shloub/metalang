Imports System
Imports System.Collections.Generic

Module prologin_template_2charline2

  Function programme_candidat(ByRef tableau1 as Char(), ByVal taille1 as Integer, ByRef tableau2 as Char(), ByVal taille2 as Integer) As Integer
    Dim out0 As Integer = 0
    For  i As Integer  = 0 to  taille1 - 1
      out0 = out0 + Asc(tableau1(i)) * i
      Console.Write(tableau1(i))
    Next
    Console.Write("--" & Chr(10) & "")
    For  j As Integer  = 0 to  taille2 - 1
      out0 = out0 + Asc(tableau2(j)) * j * 100
      Console.Write(tableau2(j))
    Next
    Console.Write("--" & Chr(10) & "")
    Return out0
  End Function
  
  
  Sub Main()
    Dim taille1 As Integer = Integer.Parse(Console.ReadLine())
    Dim taille2 As Integer = Integer.Parse(Console.ReadLine())
    Dim tableau1 As Char() = Console.ReadLine().ToCharArray()
    Dim tableau2 As Char() = Console.ReadLine().ToCharArray()
    Console.Write("" & programme_candidat(tableau1, taille1, tableau2, taille2) & "" & Chr(10) & "")
  End Sub
  
End Module

