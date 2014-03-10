using System;

public class record3
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
  
  public static int result(toto[] t_, int len)
  {
    int out_ = 0;
    for (int j = 0 ; j < len; j++)
    {
      t_[j].blah = t_[j].blah + 1;
      out_ = out_ + t_[j].foo + t_[j].blah * t_[j].bar + t_[j].bar * t_[j].foo;
    }
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int a = 4;
    toto[] t_ = new toto[a];
    for (int i = 0 ; i < a; i++)
      t_[i] = mktoto(i);
    t_[0].bar = readInt();
    stdin_sep();
    t_[1].blah = readInt();
    int b = result(t_, 4);
    Console.Write(b);
    int c = t_[2].blah;
    Console.Write(c);
  }
  
}

