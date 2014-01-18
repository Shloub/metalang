using System;

public class brainfuck_compiler
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
  
  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  public static void Main(String[] args)
  {
    char input = (char)32;
    int current_pos = 500;
    int e = 1000;
    int[] mem = new int[e];
    for (int i = 0 ; i < e; i++)
      mem[i] = 0;
  }
  
}

