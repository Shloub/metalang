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

int programme_candidat(int[][] tableau, int x, int y)
{
  int out0 = 0
  for (int i = 0; i < y; i++)
      for (int j = 0; j < x; j++)
          out0 += tableau[i][j] * (i * 2 + j)
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
int taille_x = Integer.parseInt(scanner.nextLine())
int taille_y = Integer.parseInt(scanner.nextLine())
int[][] tableau = new int[taille_y][]
for (int a = 0; a < taille_y; a++)
    tableau[a] = read_int_line()
System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y))

