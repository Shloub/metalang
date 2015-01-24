import java.util.*;

public class small_inline
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int[] c = new int[2];
    for (int d = 0 ; d < 2; d++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        c[d] = -scanner.nextInt();
      }else{
        c[d] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%d - %d\n", c[0], c[1]);
  }
  
}

