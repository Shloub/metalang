Imports System

Module aaa_021if

  Sub testA(ByVal a as Boolean, ByVal b as Boolean)
    If a Then
        If b Then
            Console.Write("A")
        Else 
            Console.Write("B")
        End If
    ElseIf b Then
        Console.Write("C")
    Else 
        Console.Write("D")
    End If
  End Sub
  
  Sub testB(ByVal a as Boolean, ByVal b as Boolean)
    If a Then
        Console.Write("A")
    ElseIf b Then
        Console.Write("B")
    Else 
        Console.Write("C")
    End If
  End Sub
  
  Sub testC(ByVal a as Boolean, ByVal b as Boolean)
    If a Then
        If b Then
            Console.Write("A")
        Else 
            Console.Write("B")
        End If
    Else 
        Console.Write("C")
    End If
  End Sub
  
  Sub testD(ByVal a as Boolean, ByVal b as Boolean)
    If a Then
        If b Then
            Console.Write("A")
        Else 
            Console.Write("B")
        End If
        Console.Write("C")
    Else 
        Console.Write("D")
    End If
  End Sub
  
  Sub testE(ByVal a as Boolean, ByVal b as Boolean)
    If a Then
        If b Then
            Console.Write("A")
        End If
    Else 
        If b Then
            Console.Write("C")
        Else 
            Console.Write("D")
        End If
        Console.Write("E")
    End If
  End Sub
  
  Sub test(ByVal a as Boolean, ByVal b as Boolean)
    testD(a, b)
    testE(a, b)
    Console.Write(Chr(10))
  End Sub
  
  Sub Main()
    test(true, true)
    test(true, false)
    test(false, true)
    test(false, false)
  End Sub
  
End Module

