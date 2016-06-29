Imports System

Module euler19

  Function is_leap(ByVal year as Integer) As Boolean
    Return year Mod 400 = 0 OrElse year Mod 100 <> 0 AndAlso year Mod 4 = 0
  End Function
  
  Function ndayinmonth(ByVal month as Integer, ByVal year as Integer) As Integer
    If month = 0 Then
        Return 31
    ElseIf month = 1 Then
        If is_leap(year) Then
            Return 29
        Else 
            Return 28
        End If
    ElseIf month = 2 Then
        Return 31
    ElseIf month = 3 Then
        Return 30
    ElseIf month = 4 Then
        Return 31
    ElseIf month = 5 Then
        Return 30
    ElseIf month = 6 Then
        Return 31
    ElseIf month = 7 Then
        Return 31
    ElseIf month = 8 Then
        Return 30
    ElseIf month = 9 Then
        Return 31
    ElseIf month = 10 Then
        Return 30
    ElseIf month = 11 Then
        Return 31
    End If
    Return 0
  End Function
  
  
  Sub Main()
    Dim month As Integer = 0
    Dim year As Integer = 1901
    Dim dayofweek As Integer = 1
    ' 01-01-1901 : mardi 
    
    Dim count As Integer = 0
    Do While year <> 2001
        
        Dim ndays As Integer = ndayinmonth(month, year)
        dayofweek = (dayofweek + ndays) Mod 7
        month = month + 1
        If month = 12 Then
            month = 0
            year = year + 1
        End If
        If dayofweek Mod 7 = 6 Then
            count = count + 1
        End If
    Loop
    Console.Write(count & Chr(10))
  End Sub
  
End Module

