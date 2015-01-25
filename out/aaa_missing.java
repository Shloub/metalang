import java.util.*;

public class aaa_missing
{
  static Scanner scanner = new Scanner(System.in);
  /*
  Ce test a été généré par Metalang.
*/
  public static int result(int len, int[] tab)
  {
    boolean[] tab2 = new boolean[len];
    for (int i = 0 ; i < len; i++)
      tab2[i] = false;
    for (int i1 = 0 ; i1 < len; i1++)
    {
      System.out.printf("%d ", tab[i1]);
      tab2[tab[i1]] = true;
    }
    System.out.print("\n");
    for (int i2 = 0 ; i2 < len; i2++)
      if (!tab2[i2])
      return i2;
    return -1;
  }
  
  
  public static void main(String args[])
  {
    int b;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      b = scanner.nextInt();
    } else {
      b = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = b;
    System.out.printf("%d\n", len);
    int[] tab = new int[len];
    for (int e = 0 ; e < len; e++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab[e] = -scanner.nextInt();
      }else{
        tab[e] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%d\n", result(len, tab));
  }
  
}

