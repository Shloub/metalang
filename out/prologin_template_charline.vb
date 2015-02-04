Imports System
Imports System.Collections.Generic

Module prologin_template_charline

  Function programme_candidat(ByRef tableau as Char(), ByVal taille as Integer) As Integer
    Dim out0 As Integer = 0
    For  i As Integer  = 0 to  taille - 1
      out0 = out0 + Asc(tableau(i)) * i
      Console.Write(tableau(i))
    Next
    Console.Write("--" & Chr(10) & "")
    Return out0
  End Function
  
  
  Sub Main()
    Dim taille As Integer = Integer.Parse(Console.ReadLine())
    Dim tableau As Char() = Console.ReadLine().ToCharArray()
    Console.Write("" & programme_candidat(tableau, taille) & "" & Chr(10) & "")
  End Sub
  
End Module

