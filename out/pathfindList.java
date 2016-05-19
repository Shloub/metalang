import java.util.*;

public class pathfindList
{
  static Scanner scanner = new Scanner(System.in);
  static int pathfind_aux(int[] cache, int[] tab, int len, int pos)
  {
    if (pos >= len - 1)
      return 0;
    else if (cache[pos] != -1)
      return cache[pos];
    else
    {
        cache[pos] = len * 2;
        int posval = pathfind_aux(cache, tab, len, tab[pos]);
        int oneval = pathfind_aux(cache, tab, len, pos + 1);
        int out0 = 0;
        if (posval < oneval)
          out0 = 1 + posval;
        else
          out0 = 1 + oneval;
        cache[pos] = out0;
        return out0;
    }
  }
  
  static int pathfind(int[] tab, int len)
  {
    int[] cache = new int[len];
    for (int i = 0; i < len; i++)
      cache[i] = -1;
    return pathfind_aux(cache, tab, len, 0);
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[] tab = new int[len];
    for (int i = 0; i < len; i++)
    {
        int tmp = 0;
        if (scanner.hasNext("^-")) {
          scanner.next("^-");
          tmp = -scanner.nextInt();
        }else{
          tmp = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        tab[i] = tmp;
    }
    int result = pathfind(tab, len);
    System.out.printf("%d", result);
  }
  
}

