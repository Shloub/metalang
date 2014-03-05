import java.util.*;

public class devine
{
  static Scanner scanner = new Scanner(System.in);
  public static boolean devine_(int nombre, int[] tab, int len)
  {
    int min_ = tab[0];
    int max_ = tab[1];
    for (int i = 2 ; i < len; i++)
    {
      System.out.printf("%d%s", i, " => ");
      int a = tab[i];
      System.out.printf("%d%s", a, "\n");
      if (tab[i] > max_ || tab[i] < min_)
        return false;
      if (tab[i] < nombre)
        min_ = tab[i];
      if (tab[i] > nombre)
        max_ = tab[i];
      if (tab[i] == nombre && len != i + 1)
        return false;
    }
    return true;
  }
  
  
  public static void main(String args[])
  {
    int nombre = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); nombre = -scanner.nextInt();
    }else{
    nombre = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d%s%d%s", nombre, " ", len, "\n");
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); tmp = -scanner.nextInt();
      }else{
      tmp = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("%d%s", tmp, " ");
      tab[i] = tmp;
    }
    System.out.print("\n");
    boolean b = devine_(nombre, tab, len);
    if (b)
      System.out.print("True");
    else
      System.out.print("False");
  }
  
}

