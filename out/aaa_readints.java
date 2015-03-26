import java.util.*;

public class aaa_readints
{
  static Scanner scanner = new Scanner(System.in);
    static int[] read_int_line(){
        String[] s = scanner.nextLine().split(" ");
        int[] out = new int[s.length];
        for (int i = 0; i < s.length; i ++)
          out[i] = Integer.parseInt(s[i]);
        return out;
    }

  
  public static void main(String args[])
  {
    int len = Integer.parseInt(scanner.nextLine());
    System.out.printf("%d=len\n", len);
    int[] tab1 = read_int_line();
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d\n", i, tab1[i]);
    }
    len = Integer.parseInt(scanner.nextLine());
    int[][] tab2 = new int[len - 1][];
    for (int a = 0 ; a < len - 1; a++)
      tab2[a] = read_int_line();
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        System.out.printf("%d ", tab2[i][j]);
      }
      System.out.print("\n");
    }
  }
  
}

