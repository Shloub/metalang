import java.util.*;

public class aaa_read0
{
  static Scanner scanner = new Scanner(System.in);
  
  static void main(String[] args)
  {
    int len;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s\n", len);
  }
  
}

