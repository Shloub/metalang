Imports System

Module linkedList

Dim eof As Boolean
Dim buffer As String
Function readChar_() As Char
  If buffer Is Nothing Then
    buffer = Console.ReadLine()
  End If
  If buffer.Length = 0 Then
    Dim tmp As String = Console.ReadLine()
    eof = (tmp Is Nothing)
    buffer = Chr(10)+tmp
  End If
  Return buffer(0)
End Function

Sub consommeChar()
  readChar_()
  buffer = buffer.Substring(1)
End Sub

Function readInt() As Integer
  Dim i As Integer = 0
  Dim s as Char = readChar_()
  Dim sign As Integer = 1
  If s = "-"C Then
    sign = -1
    consommeChar()
  End If
  Do
    Dim c as Char = readChar_()
    If c <= "9"C And c >= "0"C Then
      i = i * 10 + Asc(c) - Asc("0"C)
      consommeChar()
    Else
      return i * sign
    End If
  Loop
End Function
  Public Class intlist
    Public head As Integer
    Public tail As intlist
  End Class
  Function cons(ByRef list as intlist, ByVal i as Integer) As intlist
    Dim out0 As intlist = new intlist()
    out0.head = i
    out0.tail = list
    Return out0
  End Function
  
  Function rev2(ByRef empty as intlist, ByRef acc as intlist, ByRef torev as intlist) As intlist
    If Object.ReferenceEquals(torev, empty) Then
      Return acc
    Else
      Dim acc2 As intlist = new intlist()
      acc2.head = torev.head
      acc2.tail = acc
      Return rev2(empty, acc, torev.tail)
    End If
  End Function
  
  Function rev(ByRef empty as intlist, ByRef torev as intlist) As intlist
    Return rev2(empty, empty, torev)
  End Function
  
  Sub test(ByRef empty as intlist)
    Dim list As intlist = empty
    Dim i As Integer = - 1
    Do While i <> 0
      i = readInt()
      If i <> 0 Then
        list = cons(list, i)
      End If
    Loop
  End Sub
  
  
  Sub Main()
    
  End Sub
  
End Module

