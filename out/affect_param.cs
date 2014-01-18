using System;

public class affect_param
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
  
  public static void foo(int a)
  {
    a = 4;
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    foo(a);
    Console.Write(a);
    Console.Write("\n");
  }
  
}

