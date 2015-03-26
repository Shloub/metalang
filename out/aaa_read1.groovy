import java.util.*;

public class aaa_read1
{
  static Scanner scanner = new Scanner(System.in);
  
  static void main(String[] args)
  {
    char[] str = new char[12];
    for (int a = 0 ; a < 12; a++)
      str[a] = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    for (int i = 0 ; i <= 11; i ++)
      print(str[i]);
  }
  
}

