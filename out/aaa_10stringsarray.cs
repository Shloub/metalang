using System;

public class aaa_10stringsarray
{
  public class toto {
    public String s;
    public int v;
  }
  static String idstring(String s)
  {
    return s;
  }
  
  static void printstring(String s)
  {
    Console.Write(idstring(s) + "\n");
  }
  
  static void print_toto(toto t)
  {
    Console.Write(t.s + " = " + t.v + "\n");
  }
  
  public static void Main(String[] args)
  {
    String[] tab = new String[2];
    for (int i = 0; i < 2; i++)
        tab[i] = idstring("chaine de test");
    for (int j = 0; j < 2; j++)
        printstring(idstring(tab[j]));
    toto a = new toto();
    a.s = "one";
    a.v = 1;
    print_toto(a);
  }
  
}

