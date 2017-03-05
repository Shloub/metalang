Imports System

Module euler28

  '
  '
  '43 44 45 46 47 48 49
  '42 21 22 23 24 25 26
  '41 20  7  8  9 10 27
  '40 19  6  1  2 11 28
  '39 18  5  4  3 12 29
  '38 17 16 15 14 13 30
  '37 36 35 34 33 32 31
  '
  '1 3 5 7 9 13 17 21 25 31 37 43 49
  '  2 2 2 2 4  4  4  4  6   6  6  6
  '
  '
  '
  
  Function sumdiag(ByVal n as Integer) As Integer
    Dim nterms As Integer = n * 2 - 1
    Dim un As Integer = 1
    Dim sum As Integer = 1
    For i As Integer = 0 To nterms - 2
        Dim d As Integer = 2 * (1 + i \ 4)
        un = un + d
        ' print int d print "=>" print un print " " 
        
        sum = sum + un
    Next
    Return sum
  End Function
  Sub Main()
    Console.Write(sumdiag(1001))
  End Sub
  
End Module

