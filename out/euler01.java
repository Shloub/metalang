import java.util.*;

public class euler01
{
  
  
  public static void main(String args[])
  {
    int sum = 0;
    for (int i = 0; i < 1000; i += 1)
        if (i % 3 == 0 || i % 5 == 0)
            sum += i;
    System.out.printf("%d\n", sum);
  }
  
}

