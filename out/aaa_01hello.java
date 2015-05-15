import java.util.*;

public class aaa_01hello
{
  
  
  public static void main(String args[])
  {
    System.out.print("Hello World");
    int a = 5;
    System.out.printf("%d \n%dfoo", (4 + 6) * 2, a);
    boolean b = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true;
    if (b)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.print("\n");
    boolean c = (3 * (4 + 5 + 6) * 2 == 45) == false;
    if (c)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.print(" ");
    boolean d = (2 == 1) == false;
    if (d)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1);
    boolean e = !(!(a == 0) && !(a == 4));
    if (e)
      System.out.print("True");
    else
      System.out.print("False");
    boolean f = true && !false && !(true && false);
    if (f)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.print("\n");
  }
  
}

