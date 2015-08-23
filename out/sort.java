import java.util.*;

public class sort
{
  static Scanner scanner = new Scanner(System.in);
  static int[] copytab(int[] tab, int len)
  {
    int[] o = new int[len];
    for (int i = 0 ; i < len; i++)
      o[i] = tab[i];
    return o;
  }
  
  static void bubblesort(int[] tab, int len)
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
  
  static void qsort0(int[] tab, int len, int i, int j)
  {
    if (i < j)
    {
      int i0 = i;
      int j0 = j;
      /* pivot : tab[0] */
      while (i != j)
        if (tab[i] > tab[j])
      {
        if (i == j - 1)
        {
          /* on inverse simplement*/
          int tmp = tab[i];
          tab[i] = tab[j];
          tab[j] = tmp;
          i ++;
        }
        else
        {
          /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
          int tmp = tab[i];
          tab[i] = tab[j];
          tab[j] = tab[i + 1];
          tab[i + 1] = tmp;
          i ++;
        }
      }
      else
        j --;
      qsort0(tab, len, i0, i - 1);
      qsort0(tab, len, i + 1, j0);
    }
  }
  
  
  public static void main(String args[])
  {
    int len = 2;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[] tab = new int[len];
    for (int i_ = 0 ; i_ < len; i_++)
    {
      int tmp = 0;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tmp = -scanner.nextInt();
      }else{
        tmp = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i_] = tmp;
    }
    int[] tab2 = copytab(tab, len);
    bubblesort(tab2, len);
    for (int i = 0 ; i < len; i++)
      System.out.printf("%d ", tab2[i]);
    System.out.print("\n");
    int[] tab3 = copytab(tab, len);
    qsort0(tab3, len, 0, len - 1);
    for (int i = 0 ; i < len; i++)
      System.out.printf("%d ", tab3[i]);
    System.out.print("\n");
  }
  
}

