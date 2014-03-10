using System;

public class record2
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
  public class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t_ = new toto();
    t_.foo = v1;
    t_.bar = 0;
    t_.blah = 0;
    return t_;
  }
  
  public static int result(toto t_)
  {
    t_.blah ++;
    return t_.foo + t_.blah * t_.bar + t_.bar * t_.foo;
  }
  
  
  public static void Main(String[] args)
  {
    toto t_ = mktoto(4);
    t_.bar = readInt();
    stdin_sep();
    t_.blah = readInt();
    int a = result(t_);
    Console.Write(a);
    int b = t_.blah;
    Console.Write(b);
  }
  
}

