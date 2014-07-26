using System;

public class inline
{
  public static void foo(int i)
  {
    Console.Write("" + i + "\n");
  }
  
  public static void foobar(int i)
  {
    Console.Write("" + i + "\n" + "foobar");
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    Console.Write("" + a + "\n");
    int b = 12;
    Console.Write("" + b + "\n" + "foobar");
    int c = 1;
    Console.Write("" + c + "\n");
  }
  
}

