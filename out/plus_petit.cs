using System;

public class plus_petit
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
  public static int go(int[] tab, int a, int b)
  {
    int m = (a + b) / 2;
    if (a == m)
    {
      if (tab[a] == m)
      {
        return b;
      }
      else
      {
        return a;
      }
    }
    int i = a;
    int j = b;
    while (i < j)
    {
      int e = tab[i];
      if (e < m)
      {
        i = i + 1;
      }
      else
      {
        j = j - 1;
        tab[i] = tab[j];
        tab[j] = e;
      }
    }
    if (i < m)
    {
      return go(tab, a, m);
    }
    else
    {
      return go(tab, m, b);
    }
  }
  
  public static int plus_petit_(int[] tab, int len)
  {
    return go(tab, 0, len);
  }
  
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      tmp = readInt();
      stdin_sep();
      tab[i] = tmp;
    }
    int h = plus_petit_(tab, len);
    Console.Write(h);
  }
  
}

