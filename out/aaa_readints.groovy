import java.util.*;

public class aaa_readints
{
  static Scanner scanner = new Scanner(System.in);
  
  static void main(String[] args)
  {
    int len;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s=len\n", len);
    int[] tab1 = new int[len];
    for (int a = 0 ; a < len; a++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab1[a] = -scanner.nextInt();
      }else{
        tab1[a] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%s=>%s\n", i, tab1[i]);
    }
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] tab2 = new int[len - 1][];
    for (int b = 0 ; b < len - 1; b++)
    {
      int[] c = new int[len];
      for (int d = 0 ; d < len; d++)
      {
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          c[d] = -scanner.nextInt();
        }else{
          c[d] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
      }
      tab2[b] = c;
    }
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        System.out.printf("%s ", tab2[i][j]);
      }
      print("\n");
    }
  }
  
}

