Imports System
Imports System.Collections.Generic

Module prologin_template_intlist

  
  
  Function programme_candidat(ByRef tableau as Integer(), ByVal taille as Integer) As Integer
    Dim out0 As Integer = 0
    For i As Integer = 0 To taille - 1
        out0 = out0 + tableau(i)
    Next
    Return out0
  End Function
  
  Sub Main()
    Dim taille As Integer = Integer.Parse(Console.ReadLine())
    Dim tableau As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    Console.Write(programme_candidat(tableau, taille) & Chr(10))
  End Sub
  
End Module

