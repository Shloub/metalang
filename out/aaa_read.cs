using System;

public class aaa_read
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
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void Main(String[] args)
  {
    int len = readInt();
    stdin_sep();
    Console.Write("" + len + "=len\n");
    len *= 2;
    Console.Write("" + "len*2=" + len + "\n");
    len /= 2;
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmpi1 = readInt();
      stdin_sep();
      Console.Write("" + i + "=>" + tmpi1 + " ");
      tab[i] = tmpi1;
    }
    Console.Write("\n");
    int[] tab2 = new int[len];
    for (int i_ = 0 ; i_ < len; i_++)
    {
      int tmpi2 = readInt();
      stdin_sep();
      Console.Write("" + i_ + "==>" + tmpi2 + " ");
      tab2[i_] = tmpi2;
    }
    int strlen = readInt();
    stdin_sep();
    Console.Write("" + strlen + "=strlen\n");
    char[] tab4 = new char[strlen];
    for (int toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = readChar();
      int c = tmpc;
      Console.Write("" + tmpc + ":" + c + " ");
      if (tmpc != (char)32)
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[toto] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
      Console.Write(tab4[j]);
  }
  
}

