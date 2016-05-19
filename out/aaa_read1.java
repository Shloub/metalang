import java.util.*;

public class aaa_read1
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    char[] str = scanner.nextLine().toCharArray();
    for (int i = 0; i <= 11; i ++)
      System.out.printf("%c", str[i]);
  }
  
}

