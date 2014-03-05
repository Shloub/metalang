using System;

public class devine
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
  public static bool devine_(int nombre, int[] tab, int len)
  {
    int min_ = tab[0];
    int max_ = tab[1];
    for (int i = 2 ; i < len; i++)
    {
      Console.Write(i);
      Console.Write(" => ");
      int a = tab[i];
      Console.Write(a);
      Console.Write("\n");
      if (tab[i] > max_ || tab[i] < min_)
        return false;
      if (tab[i] < nombre)
        min_ = tab[i];
      if (tab[i] > nombre)
        max_ = tab[i];
      if (tab[i] == nombre && len != i + 1)
        return false;
    }
    return true;
  }
  
  
  public static void Main(String[] args)
  {
    int nombre = 0;
    nombre = readInt();
    stdin_sep();
    int len = 0;
    len = readInt();
    stdin_sep();
    Console.Write(nombre);
    Console.Write(" ");
    Console.Write(len);
    Console.Write("\n");
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      tmp = readInt();
      stdin_sep();
      Console.Write(tmp);
      Console.Write(" ");
      tab[i] = tmp;
    }
    Console.Write("\n");
    bool b = devine_(nombre, tab, len);
    if (b)
      Console.Write("True");
    else
      Console.Write("False");
  }
  
}

