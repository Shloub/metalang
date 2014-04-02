import java.util.*;

public class euler01
{
  static Scanner scanner = new Scanner(System.in);
  
  
  public static void main(String args[])
  {
    int sum = 0;
    for (int i = 0 ; i <= 999; i ++)
      if ((i % 3) == 0 || (i % 5) == 0)
      sum += i;
    System.out.printf("%d%s", sum, "\n");
  }
  
}

