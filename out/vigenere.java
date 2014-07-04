import java.util.*;

public class vigenere
{
  static Scanner scanner = new Scanner(System.in);
  public static int position_alphabet(char c)
  {
    int i = c;
    if (i <= 'Z' && i >= 'A')
      return i - 'A';
    else if (i <= 'z' && i >= 'a')
      return i - 'a';
    else
      return -1;
  }
  
  public static char of_position_alphabet(int c)
  {
    return (char)(c + 'a');
  }
  
  public static void crypte(int taille_cle, char[] cle, int taille, char[] message)
  {
    for (int i = 0 ; i < taille; i++)
    {
      int lettre = position_alphabet(message[i]);
      if (lettre != -1)
      {
        int addon = position_alphabet(cle[i % taille_cle]);
        int new_ = (addon + lettre) % 26;
        message[i] = of_position_alphabet(new_);
      }
    }
  }
  
  
  public static void main(String args[])
  {
    int taille_cle = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); taille_cle = -scanner.nextInt();
    }else{
    taille_cle = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] cle = new char[taille_cle];
    for (int index = 0 ; index < taille_cle; index++)
    {
      char out_ = '_';
      out_ = scanner.findWithinHorizon(".", 1).charAt(0);
      cle[index] = out_;
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); taille = -scanner.nextInt();
    }else{
    taille = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] message = new char[taille];
    for (int index2 = 0 ; index2 < taille; index2++)
    {
      char out2 = '_';
      out2 = scanner.findWithinHorizon(".", 1).charAt(0);
      message[index2] = out2;
    }
    crypte(taille_cle, cle, taille, message);
    for (int i = 0 ; i < taille; i++)
    {
      char a = message[i];
      System.out.printf("%c", a);
    }
    System.out.print("\n");
  }
  
}

