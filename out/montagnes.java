import java.util.*;

public class montagnes
{
  static Scanner scanner = new Scanner(System.in);
  public static int montagnes_(int[] tab, int len)
  {
    int max_ = 1;
    int j = 1;
    int i = len - 2;
    while (i >= 0)
    {
      int x = tab[i];
      while (j >= 0 && x > tab[len - j])
        j --;
      j ++;
      tab[len - j] = x;
      if (j > max_)
        max_ = j;
      i --;
    }
    return max_;
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int x = 0;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        x = -scanner.nextInt();
      }else{
        x = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = x;
    }
    System.out.printf("%d", montagnes_(tab, len));
  }
  
}

