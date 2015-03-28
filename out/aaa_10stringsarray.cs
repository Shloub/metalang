using System;

public class aaa_10stringsarray
{
  /*
TODO ajouter un record qui contient des chaines.
*/
  static String idstring(String s)
  {
    return s;
  }
  
  static void printstring(String s)
  {
    Console.Write("" + idstring(s) + "\n");
  }
  
  
  public static void Main(String[] args)
  {
    String[] tab = new String[2];
    for (int i = 0 ; i < 2; i++)
      tab[i] = idstring("chaine de test");
    for (int j = 0 ; j <= 1; j ++)
      printstring(idstring(tab[j]));
  }
  
}

