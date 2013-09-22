import java.util.*;

public class summax_souslist
{
  static Scanner scanner = new Scanner(System.in);
  public static int summax(int[] lst, int len)
  {
    int current = 0;
    int max_ = 0;
    for (int i = 0 ; i < len; i++)
    {
      current += lst[i];
      if (current < 0)
        current = 0;
      if (max_ < current)
        max_ = current;
    }
    return max_;
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); tmp = -scanner.nextInt();
      }else{
      tmp = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = tmp;
    }
    int result = summax(tab, len);
    System.out.printf("%d", result);
  }
  
}

