using System;

public class aaa_02if
{
  static bool f(int i)
  {
    if (i == 0)
      return true;
    return false;
  }
  
  
  public static void Main(String[] args)
  {
    if (f(4))
      Console.Write("true <-\n ->\n");
    else
      Console.Write("false <-\n ->\n");
    Console.Write("small test end\n");
  }
  
}

