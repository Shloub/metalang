Imports System

Module euler06

  
  Sub Main()
    Dim lim As Integer = 100
    Dim sum As Integer = lim * (lim + 1) \ 2
    Dim carressum As Integer = sum * sum
    Dim sumcarres As Integer = lim * (lim + 1) * (2 * lim + 1) \ 6
    Console.Write(carressum - sumcarres)
  End Sub
  
End Module

