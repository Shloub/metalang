using System;

public class aaa_04loop
{
  
  public static void Main(String[] args)
  {
    int j = 0;
    for (int k = 0 ; k <= 10; k ++)
    {
      j += k;
      Console.Write("" + j + "\n");
    }
    int i = 4;
    while (i < 10)
    {
      Console.Write(i);
      i ++;
      j += i;
    }
    Console.Write("" + j + i + "FIN TEST\n");
  }
  
}

