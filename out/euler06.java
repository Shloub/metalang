import java.util.*;

public class euler06
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int lim = 100;
    int sum = (lim * (lim + 1)) / 2;
    int carressum = sum * sum;
    int sumcarres = (lim * (lim + 1) * (2 * lim + 1)) / 6;
    System.out.printf("%d", carressum - sumcarres);
  }
  
}

