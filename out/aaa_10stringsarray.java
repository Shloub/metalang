import java.util.*;

public class aaa_10stringsarray
{
  
  static class toto {
    public String s;
    public int v;
  }
  static String idstring(String s)
  {
    return s;
  }
  
  static void printstring(String s)
  {
    System.out.printf("%s\n", idstring(s));
  }
  
  static void print_toto(toto t)
  {
    System.out.printf("%s = %d\n", t.s, t.v);
  }
  
  
  public static void main(String args[])
  {
    String[] tab = new String[2];
    for (int i = 0; i < 2; i++)
      tab[i] = idstring("chaine de test");
    for (int j = 0; j <= 1; j ++)
      printstring(idstring(tab[j]));
    toto a = new toto();
    a.s = "one";
    a.v = 1;
    print_toto(a);
  }
  
}

