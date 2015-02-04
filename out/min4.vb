Imports System

Module min4

  
  Sub Main()
    Console.Write("" & Math.Min(Math.Min(Math.Min(1, 2), 3), 4) & " " & Math.Min(Math.Min(Math.Min(1, 2), 4), 3) & " " & Math.Min(Math.Min(Math.Min(1, 3), 2), 4) & " " & Math.Min(Math.Min(Math.Min(1, 3), 4), 2) & " " & Math.Min(Math.Min(Math.Min(1, 4), 2), 3) & " " & Math.Min(Math.Min(Math.Min(1, 4), 3), 2) & "" & Chr(10) & "" & Math.Min(Math.Min(Math.Min(2, 1), 3), 4) & " " & Math.Min(Math.Min(Math.Min(2, 1), 4), 3) & " " & Math.Min(Math.Min(Math.Min(2, 3), 1), 4) & " " & Math.Min(Math.Min(Math.Min(2, 3), 4), 1) & " " & Math.Min(Math.Min(Math.Min(2, 4), 1), 3) & " " & Math.Min(Math.Min(Math.Min(2, 4), 3), 1) & "" & Chr(10) & "" & Math.Min(Math.Min(Math.Min(3, 1), 2), 4) & " " & Math.Min(Math.Min(Math.Min(3, 1), 4), 2) & " " & Math.Min(Math.Min(Math.Min(3, 2), 1), 4) & " " & Math.Min(Math.Min(Math.Min(3, 2), 4), 1) & " " & Math.Min(Math.Min(Math.Min(3, 4), 1), 2) & " " & Math.Min(Math.Min(Math.Min(3, 4), 2), 1) & "" & Chr(10) & "" & Math.Min(Math.Min(Math.Min(4, 1), 2), 3) & " " & Math.Min(Math.Min(Math.Min(4, 1), 3), 2) & " " & Math.Min(Math.Min(Math.Min(4, 2), 1), 3) & " " & Math.Min(Math.Min(Math.Min(4, 2), 3), 1) & " " & Math.Min(Math.Min(Math.Min(4, 3), 1), 2) & " " & Math.Min(Math.Min(Math.Min(4, 3), 2), 1) & "" & Chr(10) & "")
  End Sub
  
End Module

