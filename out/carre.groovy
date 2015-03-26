import java.util.*;

public class carre
{
  static Scanner scanner = new Scanner(System.in);
  
  static void main(String[] args)
  {
    int x;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      x = scanner.nextInt();
    } else {
      x = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int y;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      y = scanner.nextInt();
    } else {
      y = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] tab = new int[y][];
    for (int d = 0 ; d < y; d++)
    {
      int[] e = new int[x];
      for (int f = 0 ; f < x; f++)
      {
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          e[f] = -scanner.nextInt();
        }else{
          e[f] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
      }
      tab[d] = e;
    }
    for (int ix = 1 ; ix < x; ix++)
      for (int iy = 1 ; iy < y; iy++)
        if (tab[iy][ix] == 1)
      tab[iy][ix] =
      Math.min(Math.min(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) +
      1;
    for (int jy = 0 ; jy < y; jy++)
    {
      for (int jx = 0 ; jx < x; jx++)
      {
        System.out.printf("%s ", tab[jy][jx]);
      }
      print("\n");
    }
  }
  
}

