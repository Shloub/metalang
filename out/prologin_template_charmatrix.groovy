import groovy.transform.Field
import java.util.*

int programme_candidat(char[][] tableau, int taille_x, int taille_y)
{
  int out0 = 0
  for (int i = 0; i < taille_y; i++)
  {
      for (int j = 0; j < taille_x; j++)
      {
          out0 += (0+tableau[i][j]) * (i + j * 2)
          print(tableau[i][j])
      }
      print("--\n")
  }
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
int taille_x = Integer.parseInt(scanner.nextLine())
int taille_y = Integer.parseInt(scanner.nextLine())
char[][] a = new char[taille_y][]
for (int b = 0; b < taille_y; b++)
    a[b] = scanner.nextLine().toCharArray()
char[][] tableau = a
System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y))

