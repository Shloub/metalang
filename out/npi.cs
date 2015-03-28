using System;

public class npi
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
  static bool is_number(char c)
  {
    return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
  }
  
  /*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
  static int npi0(char[] str, int len)
  {
    int[] stack = new int[len];
    for (int i = 0 ; i < len; i++)
      stack[i] = 0;
    int ptrStack = 0;
    int ptrStr = 0;
    while (ptrStr < len)
      if (str[ptrStr] == (char)32)
      ptrStr ++;
    else if (is_number(str[ptrStr]))
    {
      int num = 0;
      while (str[ptrStr] != (char)32)
      {
        num = num * 10 + (int)(str[ptrStr]) - (int)('0');
        ptrStr ++;
      }
      stack[ptrStack] = num;
      ptrStack ++;
    }
    else if (str[ptrStr] == (char)43)
    {
      stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
      ptrStack --;
      ptrStr ++;
    }
    return stack[0];
  }
  
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    char[] tab = new char[len];
    for (int i = 0 ; i < len; i++)
    {
      char tmp = (char)0;
      tmp = readChar();
      tab[i] = tmp;
    }
    int result = npi0(tab, len);
    Console.Write(result);
  }
  
}

