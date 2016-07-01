import java.util.*;

public class small_inline
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int[] t = new int[2];
    for (int d = 0; d < 2; d += 1)
    {
        if (scanner.hasNext("^-")) {
          scanner.next("^-");
          t[d] = -scanner.nextInt();
        }else{
          t[d] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%d - %d\n", t[0], t[1]);
  }
  
}

