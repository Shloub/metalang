import java.util.*;

public class affect_param
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
  
  public static void foo(int a)
  {
    a = 4;
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    foo(a);
    System.out.printf("%d", a);
    System.out.printf("%s", "\n");
  }
  
}

