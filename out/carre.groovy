import groovy.transform.Field
import java.util.*

  int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }


@Field Scanner scanner = new Scanner(System.in)
int x = Integer.parseInt(scanner.nextLine())
int y = Integer.parseInt(scanner.nextLine())
int[][] tab = new int[y][]
for (int d = 0; d < y; d++)
    tab[d] = read_int_line()
for (int ix = 1; ix < x; ix++)
    for (int iy = 1; iy < y; iy++)
        if (tab[iy][ix] == 1)
            tab[iy][ix] = Math.min(Math.min(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1
for (int jy = 0; jy < y; jy++)
{
    for (int jx = 0; jx < x; jx++)
        System.out.printf("%d ", tab[jy][jx])
    print("\n")
}

