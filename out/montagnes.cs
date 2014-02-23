using System;
using System.Collections.Generic;

public class montagnes
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
  public static int montagnes_(int[] tab, int len)
  {
    int max_ = 1;
    int j = 1;
    int i = len - 2;
    while (i >= 0)
    {
      int x = tab[i];
      while (j >= 0 && x > tab[len - j])
        j --;
      j ++;
      tab[len - j] = x;
      if (j > max_)
        max_ = j;
      i --;
    }
    return max_;
  }
  
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int x = 0;
      x = readInt();
      stdin_sep();
      tab[i] = x;
    }
    int a = montagnes_(tab, len);
    Console.Write(a);
  }
  
}

