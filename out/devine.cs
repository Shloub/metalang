using System;

public class devine
{
static bool eof;
static String buffer;
static char readChar_(){
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
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
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
  static bool devine0(int nombre, int[] tab, int len)
  {
    int min0 = tab[0];
    int max0 = tab[1];
    for (int i = 2 ; i < len; i++)
    {
      if (tab[i] > max0 || tab[i] < min0)
        return false;
      if (tab[i] < nombre)
        min0 = tab[i];
      if (tab[i] > nombre)
        max0 = tab[i];
      if (tab[i] == nombre && len != i + 1)
        return false;
    }
    return true;
  }
  
  
  public static void Main(String[] args)
  {
    int nombre = readInt();
    stdin_sep();
    int len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = readInt();
      stdin_sep();
      tab[i] = tmp;
    }
    bool a = devine0(nombre, tab, len);
    if (a)
      Console.Write("True");
    else
      Console.Write("False");
  }
  
}

