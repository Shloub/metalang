import java.util.*;

public class aaa_missing
{
  static Scanner scanner = new Scanner(System.in);
  public static int read_int()
  {
    int out_ = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); out_ = -scanner.nextInt();
    }else{
    out_ = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    return out_;
  }
  
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); t = -scanner.nextInt();
      }else{
      t = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = t;
    }
    return tab;
  }
  
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
    int len = read_int();
    System.out.printf("%d\n", len);
    int[] tab = read_int_line(len);
    int a = result(len, tab);
    System.out.printf("%d", a);
  }
  
}

