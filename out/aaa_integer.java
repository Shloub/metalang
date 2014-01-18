import java.util.*;

public class aaa_integer
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
  
  
  public static void main(String args[])
  {
    int i = 0;
    i ++;
    System.out.printf("%d", i);
    i += 55;
    System.out.printf("%d", i);
    i *= 13;
    System.out.printf("%d", i);
    i /= 2;
    System.out.printf("%d", i);
    i ++;
    System.out.printf("%d", i);
    i /= 3;
    System.out.printf("%d", i);
    i --;
    System.out.printf("%d", i);
  }
  
}

