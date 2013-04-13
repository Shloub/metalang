import java.util.*;

public class pathfindList
{
  static Scanner scanner = new Scanner(System.in);
  public static int pathfind_aux(int[] cache, int[] tab, int len, int pos)
  {
    if (pos >= (len - 1))
    {
      return 0;
    }
    else if (cache[pos] != -1)
    {
      return cache[pos];
    }
    else
    {
      cache[pos] = len * 2;
      int posval = pathfind_aux(cache, tab, len, tab[pos]);
      int oneval = pathfind_aux(cache, tab, len, pos + 1);
      int out_ = 0;
      if (posval < oneval)
      {
        out_ = 1 + posval;
      }
      else
      {
        out_ = 1 + oneval;
      }
      cache[pos] = out_;
      return out_;
    }
  }
  
  public static int pathfind(int[] tab, int len)
  {
    int[] cache = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      cache[i] = -1;
    }
    return pathfind_aux(cache, tab, len, 0);
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      scanner.useDelimiter("\\s");
      tmp = scanner.nextInt();
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = tmp;
    }
    int result = pathfind(tab, len);
    System.out.printf("%d", result);
  }
  
}

