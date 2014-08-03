import java.util.*;

public class aaa_04loop
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int j = 0;
    for (int k = 0 ; k <= 10; k ++)
    {
      j += k;
      System.out.printf("%d\n", j);
    }
    int i = 4;
    while (i < 10)
    {
      System.out.printf("%d", i);
      i ++;
      j += i;
    }
    System.out.printf("%d%dFIN TEST\n", j, i);
  }
  
}

