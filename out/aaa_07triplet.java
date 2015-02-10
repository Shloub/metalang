import java.util.*;

public class aaa_07triplet
{
  static Scanner scanner = new Scanner(System.in);
    static int[] read_int_line(){
        String s[] = scanner.nextLine().split(" ");
        int out[] = new int[s.length];
        for (int i = 0; i < s.length; i ++)
          out[i] = Integer.parseInt(s[i]);
        return out;
    }

  
  public static void main(String args[])
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int[] k = read_int_line();
      int a = k[0];
      int b = k[1];
      int c = k[2];
      System.out.printf("a = %d b = %dc =%d\n", a, b, c);
    }
    int[] l = read_int_line();
    for (int j = 0 ; j <= 9; j ++)
    {
      System.out.printf("%d\n", l[j]);
    }
  }
  
}

