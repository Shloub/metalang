using System;

public class dichoexp
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
  public static int exp_(int a, int b)
  {
    if (b == 0)
    {
      return 1;
    }
    if ((b % 2) == 0)
    {
      int o = exp_(a, b / 2);
      return o * o;
    }
    else
    {
      return a * exp_(a, b - 1);
    }
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    int b = 0;
    a = readInt();
    stdin_sep();
    b = readInt();
    int f = exp_(a, b);
    Console.Write(f);
  }
  
}

