using System;

public class aaa_04loop
{
  static bool h(int i)
  {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    int j = i - 2;
    while (j <= i + 2)
    {
        if (i % j == 5)
            return true;
        j += 1;
    }
    return false;
  }
  
  
  public static void Main(String[] args)
  {
    int j = 0;
    for (int k = 0; k < 11; k += 1)
    {
        j += k;
        Console.Write(j + "\n");
    }
    int i = 4;
    while (i < 10)
    {
        Console.Write(i);
        i += 1;
        j += i;
    }
    Console.Write("" + j + i + "FIN TEST\n");
  }
  
}

