using System;

public class affect_param
{
  public static void foo(int a)
  {
    a = 4;
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    foo(a);
    Console.Write(a + "\n");
  }
  
}

