using System;

public class aaa_integer
{
  enum lng { 
    LANG_C,
     LANG_Pas,
     LANG_Cc,
     LANG_Cs,
     LANG_Java,
     LANG_Js,
     LANG_Ml,
     LANG_Php,
     LANG_Rb,
     LANG_Py,
     LANG_Tex,
     LANG_Metalang}
  
  
  public static void Main(String[] args)
  {
    int i = 0;
    i ++;
    Console.Write(i);
    i += 55;
    Console.Write(i);
    i *= 13;
    Console.Write(i);
    i /= 2;
    Console.Write(i);
    i ++;
    Console.Write(i);
    i /= 3;
    Console.Write(i);
    i --;
    Console.Write(i);
  }
  
}

