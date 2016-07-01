import java.util.*;

public class carre
{
  static Scanner scanner = new Scanner(System.in);
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

  
  public static void main(String args[])
  {
    int x = Integer.parseInt(scanner.nextLine());
    int y = Integer.parseInt(scanner.nextLine());
    int[][] tab = new int[y][];
    for (int d = 0; d < y; d += 1)
        tab[d] = read_int_line();
    for (int ix = 1; ix < x; ix += 1)
        for (int iy = 1; iy < y; iy += 1)
            if (tab[iy][ix] == 1)
                tab[iy][ix] = Math.min(Math.min(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
    for (int jy = 0; jy < y; jy += 1)
    {
        for (int jx = 0; jx < x; jx += 1)
            System.out.printf("%d ", tab[jy][jx]);
        System.out.print("\n");
    }
  }
  
}

