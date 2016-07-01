using System;

public class vigenere
{
static bool eof;
static String buffer;
static char readChar_(){
  if (buffer == null || buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = tmp + "\n";
  }
  char c = buffer[0];
  return c;
}
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
static void stdin_sep(){
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
static int readInt(){
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
    for (int i = 0; i < taille; i += 1)
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
    for (int index = 0; index < taille_cle; index += 1)
    {
        char out0 = readChar();
        cle[index] = out0;
    }
    stdin_sep();
    int taille = readInt();
    stdin_sep();
    char[] message = new char[taille];
    for (int index2 = 0; index2 < taille; index2 += 1)
    {
        char out2 = readChar();
        message[index2] = out2;
    }
    crypte(taille_cle, cle, taille, message);
    for (int i = 0; i < taille; i += 1)
        Console.Write(message[i]);
    Console.Write("\n");
  }
  
}

