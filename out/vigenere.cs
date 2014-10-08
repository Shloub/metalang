using System;

public class vigenere
{
static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
public static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}
public static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
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
        int new0 = (addon + lettre) % 26;
        message[i] = of_position_alphabet(new0);
      }
    }
  }
  
  
  public static void Main(String[] args)
  {
    int taille_cle = readInt();
    stdin_sep();
    char[] cle = new char[taille_cle];
    for (int index = 0 ; index < taille_cle; index++)
    {
      char out0 = readChar();
      cle[index] = out0;
    }
    stdin_sep();
    int taille = readInt();
    stdin_sep();
    char[] message = new char[taille];
    for (int index2 = 0 ; index2 < taille; index2++)
    {
      char out2 = readChar();
      message[index2] = out2;
    }
    crypte(taille_cle, cle, taille, message);
    for (int i = 0 ; i < taille; i++)
      Console.Write(message[i]);
    Console.Write("\n");
  }
  
}

