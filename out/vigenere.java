import java.util.*;

public class vigenere
{
  static Scanner scanner = new Scanner(System.in);
  static int position_alphabet(char c)
  {
    int i = (int)(c);
    if (i <= (int)('Z') && i >= (int)('A'))
      return i - (int)('A');
    else if (i <= (int)('z') && i >= (int)('a'))
      return i - (int)('a');
    else
      return -1;
  }
  
  static char of_position_alphabet(int c)
  {
    return (char)(c + (int)('a'));
  }
  
  static void crypte(int taille_cle, char[] cle, int taille, char[] message)
  {
    for (int i = 0; i < taille; i++)
    {
        int lettre = position_alphabet(message[i]);
        if (lettre != -1)
        {
            int addon = position_alphabet(cle[i % taille_cle]);
            int new0 = (addon + lettre) % 26;
            message[i] = of_position_alphabet(new0);
        }
    }
  }
  
  
  public static void main(String args[])
  {
    int taille_cle;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      taille_cle = scanner.nextInt();
    } else {
      taille_cle = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] cle = new char[taille_cle];
    for (int index = 0; index < taille_cle; index++)
    {
        char out0 = scanner.findWithinHorizon(".", 1).charAt(0);
        cle[index] = out0;
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      taille = scanner.nextInt();
    } else {
      taille = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] message = new char[taille];
    for (int index2 = 0; index2 < taille; index2++)
    {
        char out2 = scanner.findWithinHorizon(".", 1).charAt(0);
        message[index2] = out2;
    }
    crypte(taille_cle, cle, taille, message);
    for (int i = 0; i < taille; i++)
      System.out.printf("%c", message[i]);
    System.out.print("\n");
  }
  
}

