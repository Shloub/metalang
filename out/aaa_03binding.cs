using System;

public class aaa_03binding
{
  public static int g(int i)
  {
    int j = i * 4;
    if ((j % 2) == 1)
      return 0;
    return j;
  }
  
  public static void h(int i)
  {
    Console.Write("" + i + "\n");
  }
  
  
  public static void Main(String[] args)
  {
    h(14);
    int a = 4;
    int b = 5;
    Console.Write(a + b);
    /* main */
    h(15);
    a = 2;
    b = 1;
    Console.Write(a + b);
  }
  
}

