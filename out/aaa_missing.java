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
      tab2[tab[i1]] = true;
    for (int i2 = 0 ; i2 < len; i2++)
      if (!tab2[i2])
      return i2;
    return -1;
  }
  
  
  public static void main(String args[])
  {
    int b = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int a = b;
    int len = a;
    System.out.printf("%d\n", len);
    int[] d = new int[len];
    for (int e = 0 ; e < len; e++)
    {
      int f = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); f = -scanner.nextInt();
      }else{
      f = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      d[e] = f;
    }
    int[] c = d;
    int[] tab = c;
    System.out.printf("%d", result(len, tab));
  }
  
}

