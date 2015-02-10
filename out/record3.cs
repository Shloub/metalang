using System;

public class record3
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
  public class toto {public int foo;public int bar;public int blah;}
  static toto mktoto(int v1)
  {
    toto t = new toto();
    t.foo = v1;
    t.bar = 0;
    t.blah = 0;
    return t;
  }
  
  static int result(toto[] t, int len)
  {
    int out0 = 0;
    for (int j = 0 ; j < len; j++)
    {
      t[j].blah = t[j].blah + 1;
      out0 = out0 + t[j].foo + t[j].blah * t[j].bar + t[j].bar * t[j].foo;
    }
    return out0;
  }
  
  
  public static void Main(String[] args)
  {
    toto[] t = new toto[4];
    for (int i = 0 ; i < 4; i++)
      t[i] = mktoto(i);
    t[0].bar = readInt();
    stdin_sep();
    t[1].blah = readInt();
    int titi = result(t, 4);
    Console.Write("" + titi + t[2].blah);
  }
  
}

