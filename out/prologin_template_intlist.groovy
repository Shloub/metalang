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

int programme_candidat(int[] tableau, int taille)
{
  int out0 = 0
  for (int i = 0; i < taille; i += 1)
      out0 += tableau[i]
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
int taille = Integer.parseInt(scanner.nextLine())
int[] tableau = read_int_line()
System.out.printf("%d\n", programme_candidat(tableau, taille))

