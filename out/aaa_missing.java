import java.util.*;

public class aaa_missing
{
  static Scanner scanner = new Scanner(System.in);
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

  /*
  Ce test a été généré par Metalang.
*/
  static int result(int len, int[] tab)
  {
    boolean[] tab2 = new boolean[len];
    for (int i = 0; i < len; i++)
        tab2[i] = false;
    for (int i1 = 0; i1 < len; i1++)
    {
        System.out.printf("%d ", tab[i1]);
        tab2[tab[i1]] = true;
    }
    System.out.print("\n");
    for (int i2 = 0; i2 < len; i2++)
        if (!tab2[i2])
            return i2;
    return -1;
  }
  
  
  public static void main(String args[])
  {
    int len = Integer.parseInt(scanner.nextLine());
    System.out.printf("%d\n", len);
    int[] tab = read_int_line();
    System.out.printf("%d\n", result(len, tab));
  }
  
}

