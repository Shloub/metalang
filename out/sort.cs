using System;
using System.Collections.Generic;

public class sort
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
  public static void sort_(int[] tab, int len)
  {
    for (int i = 0 ; i < len; i++)
      for (int j = i + 1 ; j < len; j++)
        if (tab[i] > tab[j])
    {
      int tmp = tab[i];
      tab[i] = tab[j];
      tab[j] = tmp;
    }
  }
  
  
  public static void Main(String[] args)
  {
    int len = 2;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i_ = 0 ; i_ < len; i_++)
    {
      int tmp = 0;
      tmp = readInt();
      stdin_sep();
      tab[i_] = tmp;
    }
    sort_(tab, len);
    for (int i = 0 ; i < len; i++)
    {
      int a = tab[i];
      Console.Write(a);
    }
  }
  
}

