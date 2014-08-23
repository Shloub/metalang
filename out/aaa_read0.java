import java.util.*;

public class aaa_read0
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int b = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = b;
    System.out.printf("%d\n", len);
  }
  
}

