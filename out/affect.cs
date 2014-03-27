using System;

public class affect
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
  /*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
  public class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t = new toto();
    t.foo = v1;
    t.bar = v1;
    t.blah = v1;
    return t;
  }
  
  public static toto mktoto2(int v1)
  {
    toto t = new toto();
    t.foo = v1 + 3;
    t.bar = v1 + 2;
    t.blah = v1 + 1;
    return t;
  }
  
  public static int result(toto t_, toto t2_)
  {
    toto t = t_;
    toto t2 = t2_;
    toto t3 = new toto();
    t3.foo = 0;
    t3.bar = 0;
    t3.blah = 0;
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah ++;
    int len = 1;
    int[] cache0 = new int[len];
    for (int i = 0 ; i < len; i++)
      cache0[i] = -i;
    int[] cache1 = new int[len];
    for (int j = 0 ; j < len; j++)
      cache1[j] = j;
    int[] cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  public static void Main(String[] args)
  {
    toto t = mktoto(4);
    toto t2 = mktoto(5);
    t.bar = readInt();
    stdin_sep();
    t.blah = readInt();
    stdin_sep();
    t2.bar = readInt();
    stdin_sep();
    t.blah = readInt();
    int a = result(t, t2);
    Console.Write(a);
    int b = t.blah;
    Console.Write(b);
  }
  
}

