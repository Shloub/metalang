import groovy.transform.Field
import java.util.*

int programme_candidat(char[] tableau, int taille)
{
  int out0 = 0
  for (int i = 0 ; i < taille; i++)
  {
    out0 += (0+tableau[i]) * i;
    print(tableau[i])
  }
  print("--\n")
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
int taille = Integer.parseInt(scanner.nextLine())
char[] tableau = scanner.nextLine().toCharArray()
System.out.printf("%s\n", programme_candidat(tableau, taille));

