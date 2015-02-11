Imports System
Imports System.Collections.Generic

Module aaa_readints

  
  Sub Main()
    Dim len As Integer = Integer.Parse(Console.ReadLine())
    Console.Write("" & len & "=len" & Chr(10))
    Dim tab1 As Integer() = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    For  i As Integer  = 0 to  len - 1
      Console.Write(i)
      Console.Write("=>")
      Console.Write(tab1(i))
      Console.Write(Chr(10))
    Next
    len = Integer.Parse(Console.ReadLine())
    Dim tab2(len - 1)() As Integer
    For  a As Integer  = 0 to  len - 1 - 1
      tab2(a) = Array(Of String).ConvertAll(Of String, Integer)(Console.ReadLine().Split(" ".ToCharArray()), New Converter(Of String, Integer)(AddressOf Integer.Parse))
    Next
    For  i As Integer  = 0 to  len - 2
      For  j As Integer  = 0 to  len - 1
        Console.Write(tab2(i)(j))
        Console.Write(" ")
      Next
      Console.Write(Chr(10))
    Next
    End Sub
    
  End Module
  
  