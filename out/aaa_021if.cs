using System;

public class aaa_021if
{
  static void testA(bool a, bool b)
  {
    if (a)
        if (b)
            Console.Write("A");
        else
            Console.Write("B");
    else if (b)
        Console.Write("C");
    else
        Console.Write("D");
  }
  
  static void testB(bool a, bool b)
  {
    if (a)
        Console.Write("A");
    else if (b)
        Console.Write("B");
    else
        Console.Write("C");
  }
  
  static void testC(bool a, bool b)
  {
    if (a)
        if (b)
            Console.Write("A");
        else
            Console.Write("B");
    else
        Console.Write("C");
  }
  
  static void testD(bool a, bool b)
  {
    if (a)
    {
        if (b)
            Console.Write("A");
        else
            Console.Write("B");
        Console.Write("C");
    }
    else
        Console.Write("D");
  }
  
  static void testE(bool a, bool b)
  {
    if (a)
    {
        if (b)
            Console.Write("A");
    }
    else
    {
        if (b)
            Console.Write("C");
        else
            Console.Write("D");
        Console.Write("E");
    }
  }
  
  static void test(bool a, bool b)
  {
    testD(a, b);
    testE(a, b);
    Console.Write("\n");
  }
  
  
  public static void Main(String[] args)
  {
    test(true, true);
    test(true, false);
    test(false, true);
    test(false, false);
  }
  
}

