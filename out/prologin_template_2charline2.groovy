import groovy.transform.Field
import java.util.*




int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
{
  int out0 = 0
  for (int i = 0; i < taille1; i++)
  {
      out0 += (0+tableau1[i]) * i
      print(tableau1[i])
  }
  print("--\n")
  for (int j = 0; j < taille2; j++)
  {
      out0 += (0+tableau2[j]) * j * 100
      print(tableau2[j])
  }
  print("--\n")
  return out0
}

@Field Scanner scanner = new Scanner(System.in)
int taille1 = Integer.parseInt(scanner.nextLine())
int taille2 = Integer.parseInt(scanner.nextLine())
char[] tableau1 = scanner.nextLine().toCharArray()
char[] tableau2 = scanner.nextLine().toCharArray()
System.out.printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2))

