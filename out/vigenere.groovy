import groovy.transform.Field
import java.util.*

int position_alphabet(char c)
{
  int i = (0+c)
  if (i <= (0+(char)'Z') && i >= (0+(char)'A'))
      return i - (0+(char)'A')
  else if (i <= (0+(char)'z') && i >= (0+(char)'a'))
      return i - (0+(char)'a')
  else
      return -1
}

char of_position_alphabet(int c)
{
  return (char)(c + (0+(char)'a'))
}

void crypte(int taille_cle, char[] cle, int taille, char[] message)
{
  for (int i = 0; i < taille; i += 1)
  {
      int lettre = position_alphabet(message[i])
      if (lettre != -1)
      {
          int addon = position_alphabet(cle[i % taille_cle])
          int new0 = (addon + lettre) % 26
          message[i] = of_position_alphabet(new0)
      }
  }
}


@Field Scanner scanner = new Scanner(System.in)
int taille_cle
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  taille_cle = scanner.nextInt()
} else {
  taille_cle = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
char[] cle = new char[taille_cle]
for (int index = 0; index < taille_cle; index += 1)
{
    char out0 = scanner.findWithinHorizon(".", 1).charAt(0)
    cle[index] = out0
}
scanner.findWithinHorizon("[\n\r ]*", 1)
int taille
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  taille = scanner.nextInt()
} else {
  taille = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
char[] message = new char[taille]
for (int index2 = 0; index2 < taille; index2 += 1)
{
    char out2 = scanner.findWithinHorizon(".", 1).charAt(0)
    message[index2] = out2
}
crypte(taille_cle, cle, taille, message)
for (int i = 0; i < taille; i += 1)
    print(message[i])
print("\n")

