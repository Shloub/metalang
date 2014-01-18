import java.util.*;

public class brainfuck_compiler
{
  static Scanner scanner = new Scanner(System.in);
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
  
  public static void main(String args[])
  {
    char input = ' ';
    int current_pos = 500;
    int f = 1000;
    int[] mem = new int[f];
    for (int i = 0 ; i < f; i++)
      mem[i] = 0;
  }
  
}

