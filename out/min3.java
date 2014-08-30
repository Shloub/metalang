import java.util.*;

public class min3
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    return Math.min(a, b);
  }
  
  
  public static void main(String args[])
  {
    System.out.printf("%d %d %d %d %d %d\n", min2(min2(2, 3), 4), min2(min2(2, 4), 3), min2(min2(3, 2), 4), min2(min2(3, 4), 2), min2(min2(4, 2), 3), min2(min2(4, 3), 2));
  }
  
}

