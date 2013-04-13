using System;

public class countchar
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



  public static int nth(char[] tab, char tofind, int len)
  {
    int out_ = 0;
    for (int i = 0 ; i <= len - 1; i ++)
    {
      if (tab[i] == tofind)
      {
        out_ = out_ + 1;
      }
    }
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    char tofind = (char)0;
    tofind = readChar();
    stdin_sep();
    char[] tab = new char[len];
    for (int i = 0 ; i <= len - 1; i ++)
    {
      char tmp = (char)0;
      tmp = readChar();
      tab[i] = tmp;
    }
    int result = nth(tab, tofind, len);
    Console.Write(result);
  }
  
}

