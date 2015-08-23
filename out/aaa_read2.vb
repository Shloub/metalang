Imports System
Imports System.Collections.Generic

Module aaa_read2

  '
  'Ce test permet de vérifier si les différents backends pour les langages implémentent bien
  'read int, read char et skip
  '
  
  
  Sub Main()
    Dim len As Integer = Integer.Parse(Console.ReadLine())
    Console.Write("" & len & "=len" & Chr(10))
    Dim tab As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For  i As Integer  = 0 to  len - 1
      Console.Write("" & i & "=>" & tab(i) & " ")
    Next
    Console.Write(Chr(10))
    Dim tab2 As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For  i_ As Integer  = 0 to  len - 1
      Console.Write("" & i_ & "==>" & tab2(i_) & " ")
    Next
    Dim strlen As Integer = Integer.Parse(Console.ReadLine())
    Console.Write("" & strlen & "=strlen" & Chr(10))
    Dim tab4 As Char() = Console.ReadLine().ToCharArray()
    For  i3 As Integer  = 0 to  strlen - 1
      Dim tmpc As Char = tab4(i3)
      Dim c As Integer = Asc(tmpc)
      Console.Write("" & tmpc & ":" & c & " ")
      If tmpc <> Chr(32) Then
        c = (c - Asc("a"C) + 13) Mod 26 + Asc("a"C)
      End If
      tab4(i3) = Chr(c)
    Next
    For  j As Integer  = 0 to  strlen - 1
      Console.Write(tab4(j))
    Next
  End Sub
  
End Module

