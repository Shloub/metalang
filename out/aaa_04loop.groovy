import java.util.*;

public class aaa_04loop
{
  
  static boolean h(int i)
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
  
  
  static void main(String[] args)
  {
    int j = 0;
    for (int k = 0 ; k <= 10; k ++)
    {
      j += k;
      System.out.printf("%s\n", j);
    }
    int i = 4;
    while (i < 10)
    {
      print(i);
      i ++;
      j += i;
    }
    System.out.printf("%s%sFIN TEST\n", j, i);
  }
  
}

