import java.util.*;

public class euler09
{
  
  
  public static void main(String args[])
  {
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (int a = 1; a < 1001; a++)
        for (int b = a + 1; b < 1001; b++)
        {
            int c = 1000 - a - b;
            int a2b2 = a * a + b * b;
            int cc = c * c;
            if (cc == a2b2 && c > a)
                System.out.printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c);
        }
  }
  
}

