import java.util.*;

public class sort
{
  static Scanner scanner = new Scanner(System.in);
  public static void sort_(int[] tab, int len)
  {
    for (int i = 0 ; i < len; i++)
      for (int j = i + 1 ; j < len; j++)
        if (tab[i] > tab[j])
    {
      int tmp = tab[i];
      tab[i] = tab[j];
      tab[j] = tmp;
    }
  }
  
  
  public static void main(String args[])
  {
    int len = 2;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[] tab = new int[len];
    for (int i_ = 0 ; i_ < len; i_++)
    {
      int tmp = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); tmp = -scanner.nextInt();
      }else{
      tmp = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i_] = tmp;
    }
    sort_(tab, len);
    for (int i = 0 ; i < len; i++)
    {
      int a = tab[i];
      System.out.printf("%d", a);
    }
  }
  
}

