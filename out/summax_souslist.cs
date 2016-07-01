using System;

public class summax_souslist
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
  static int summax(int[] lst, int len)
  {
    int current = 0;
    int max0 = 0;
    for (int i = 0; i < len; i += 1)
    {
        current += lst[i];
        if (current < 0)
            current = 0;
        if (max0 < current)
            max0 = current;
    }
    return max0;
  }
  
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i = 0; i < len; i += 1)
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

