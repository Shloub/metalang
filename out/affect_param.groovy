import java.util.*;

public class affect_param
{
  
  static void foo(int a)
  {
    a = 4;
  }
  
  
  static void main(String[] args)
  {
    int a = 0;
    foo(a);
    System.out.printf("%s\n", a);
  }
  
}

