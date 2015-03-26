import java.util.*;

public class aaa_06readcouple
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
    for (int i = 1 ; i <= 3; i ++)
    {
      int[] c = read_int_line();
      int a = c[0];
      int b = c[1];
      System.out.printf("a = %d b = %d\n", a, b);
    }
    int[] l = read_int_line();
    for (int j = 0 ; j <= 9; j ++)
    {
      System.out.printf("%d\n", l[j]);
    }
  }
  
}

