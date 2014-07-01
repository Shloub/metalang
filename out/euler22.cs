using System;

public class euler22
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
  
  public static int score()
  {
    stdin_sep();
    int len = 0;
    len = readInt();
    stdin_sep();
    int sum = 0;
    for (int i = 1 ; i <= len; i ++)
    {
      char c = '_';
      c = readChar();
      sum += (c - 'A') + 1;
      /*		print c print " " print sum print " " */
    }
    return sum;
  }
  
  
  public static void Main(String[] args)
  {
    int sum = 0;
    int n = 0;
    n = readInt();
    for (int i = 1 ; i <= n; i ++)
      sum += i * score();
    Console.Write(sum + "\n");
  }
  
}

