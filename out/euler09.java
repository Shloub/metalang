import java.util.*;

public class euler09
{
  static Scanner scanner = new Scanner(System.in);
  
  
  public static void main(String args[])
  {
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (int a = 1 ; a <= 1000; a ++)
      for (int b = a + 1 ; b <= 1000; b ++)
      {
        int c = 1000 - a - b;
        int a2b2 = a * a + b * b;
        int cc = c * c;
        if (cc == a2b2 && c > a)
        {
          System.out.printf("%d\n%d\n%d\n", a, b, c);
          int d = a * b * c;
          System.out.printf("%d\n", d);
        }
    }
  }
  
}

