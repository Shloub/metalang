using System;

public class bigints
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
  
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public class bigint {public bool sign;public int chiffres_len;public int[] chiffres;}
  public static bigint read_big_int()
  {
    Console.Write("read_big_int");
    int len = 0;
    len = readInt();
    stdin_sep();
    Console.Write(len);
    Console.Write("=len ");
    char sign = '_';
    sign = readChar();
    Console.Write(sign);
    Console.Write("=sign\n");
    int[] chiffres = new int[len];
    for (int d = 0 ; d < len; d++)
    {
      char c = '_';
      c = readChar();
      Console.Write(c);
      Console.Write("=c\n");
      chiffres[d] = c - '0';
    }
    for (int i = 0 ; i <= len / 2; i ++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
    stdin_sep();
    bigint out_ = new bigint();
    out_.sign = sign == (char)43;
    out_.chiffres_len = len;
    out_.chiffres = chiffres;
    return out_;
  }
  
  public static void print_big_int(bigint a)
  {
    if (a.sign)
      Console.Write("+");
    else
      Console.Write("-");
    for (int i = 0 ; i < a.chiffres_len; i++)
    {
      int e = a.chiffres[i];
      Console.Write(e);
    }
  }
  
  public static bigint neg_big_int(bigint a)
  {
    bigint out_ = new bigint();
    out_.sign = !a.sign;
    out_.chiffres_len = a.chiffres_len;
    out_.chiffres = a.chiffres;
    return out_;
  }
  
  public static bigint add_big_int(bigint a, bigint b)
  {
    int len = max2(a.chiffres_len, b.chiffres_len) + 1;
    int retenue = 0;
    bool sign = true;
    int[] chiffres = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a.chiffres_len)
        tmp += a.chiffres[i];
      if (i < b.chiffres_len)
        tmp += b.chiffres[i];
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    }
    bigint out_ = new bigint();
    out_.sign = sign;
    out_.chiffres_len = len;
    out_.chiffres = chiffres;
    return out_;
  }
  
  /*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/
  
  public static void Main(String[] args)
  {
    bigint a = read_big_int();
    bigint b = read_big_int();
    print_big_int(add_big_int(a, b));
  }
  
}

