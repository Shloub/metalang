using System;

public class aaa_04loop
{
  public static bool h(int i)
  {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    int j = i - 2;
    while (j <= i + 2)
    {
      if ((i % j) == 5)
        return true;
      j ++;
    }
    return false;
  }
  
  
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

