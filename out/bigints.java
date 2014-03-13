import java.util.*;

public class bigints
{
  static Scanner scanner = new Scanner(System.in);
  
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  static class bigint {public boolean sign;public int chiffres_len;public int[] chiffres;}
  public static bigint read_big_int()
  {
    System.out.print("read_big_int");
    int len = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d%s", len, "=len ");
    char sign = '_';
    sign = scanner.findWithinHorizon(".", 1).charAt(0);
    System.out.printf("%c%s", sign, "=sign\n");
    int[] chiffres = new int[len];
    for (int d = 0 ; d < len; d++)
    {
      char c = '_';
      c = scanner.findWithinHorizon(".", 1).charAt(0);
      System.out.printf("%c%s", c, "=c\n");
      chiffres[d] = c - '0';
    }
    for (int i = 0 ; i <= len / 2; i ++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    bigint out_ = new bigint();
    out_.sign = sign == '+';
    out_.chiffres_len = len;
    out_.chiffres = chiffres;
    return out_;
  }
  
  public static void print_big_int(bigint a)
  {
    if (a.sign)
      System.out.print("+");
    else
      System.out.print("-");
    for (int i = 0 ; i < a.chiffres_len; i++)
    {
      int e = a.chiffres[i];
      System.out.printf("%d", e);
    }
  }
  
  public static bigint neg_big_int(bigint a)
  {
    bigint out_ = new bigint();
    out_.sign = !a.sign;
    out_.chiffres_len = a.chiffres_len;
    out_.chiffres = a.chiffres;
    return out_;
  }
  
  public static bigint add_big_int(bigint a, bigint b)
  {
    int len = max2(a.chiffres_len, b.chiffres_len) + 1;
    int retenue = 0;
    boolean sign = true;
    int[] chiffres = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a.chiffres_len)
        tmp += a.chiffres[i];
      if (i < b.chiffres_len)
        tmp += b.chiffres[i];
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    }
    bigint out_ = new bigint();
    out_.sign = sign;
    out_.chiffres_len = len;
    out_.chiffres = chiffres;
    return out_;
  }
  
  /*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/
  
  public static void main(String args[])
  {
    bigint a = read_big_int();
    bigint b = read_big_int();
    print_big_int(add_big_int(a, b));
  }
  
}

