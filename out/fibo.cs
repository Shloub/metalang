using System;

public class fibo
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
  /*
La suite de fibonaci
*/
  static int fibo0(int a, int b, int i)
  {
    int out0 = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0 ; j <= i + 1; j ++)
    {
      out0 += a2;
      int tmp = b2;
      b2 += a2;
      a2 = tmp;
    }
    return out0;
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    int b = 0;
    int i = 0;
    a = readInt();
    stdin_sep();
    b = readInt();
    stdin_sep();
    i = readInt();
    Console.Write(fibo0(a, b, i));
  }
  
}

