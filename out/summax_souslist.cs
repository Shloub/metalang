using System;

public class summax_souslist
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
  public static int summax(int[] lst, int len)
  {
    int current = 0;
    int max_ = 0;
    for (int i = 0 ; i < len; i++)
    {
      current += lst[i];
      if (current < 0)
        current = 0;
      if (max_ < current)
        max_ = current;
    }
    return max_;
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
    int result = summax(tab, len);
    Console.Write(result);
  }
  
}

