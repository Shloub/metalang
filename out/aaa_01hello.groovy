import java.util.*;

public class aaa_01hello
{
  
  
  static void main(String[] args)
  {
    print("Hello World");
    int a = 5;
    System.out.printf("%s \n%sfoo", (4 + 6) * 2, a);
    boolean b = 1 + (int)(((1 + 1) * 2 * (3 + 8)) / 4) - (1 - 2) - 3 == 12 && true;
    if (b)
      print("True");
    else
      print("False");
    print("\n");
    boolean c = (3 * (4 + 5 + 6) * 2 == 45) == false;
    if (c)
      print("True");
    else
      print("False");
    System.out.printf("%s%s", (int)(((int)((4 + 1) / 3)) / (2 + 1)), (int)(((int)(
                                                                             (4 *
                                                                               1) /
                                                                             3)) / (2 *
                                                                                1)));
    boolean d = !(!(a == 0) && !(a == 4));
    if (d)
      print("True");
    else
      print("False");
    boolean e = true && !false && !(true && false);
    if (e)
      print("True");
    else
      print("False");
    print("\n");
  }
  
}

