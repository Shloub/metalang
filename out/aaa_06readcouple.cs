using System;

public class aaa_06readcouple
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
  public class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  
  public static void Main(String[] args)
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int d = readInt();
      stdin_sep();
      int e = readInt();
      stdin_sep();
      tuple_int_int f = new tuple_int_int();
      f.tuple_int_int_field_0 = d;
      f.tuple_int_int_field_1 = e;
      int a = f.tuple_int_int_field_0;
      int b = f.tuple_int_int_field_1;
      Console.Write("" + "a = " + a + " b = " + b + "\n");
    }
  }
  
}

