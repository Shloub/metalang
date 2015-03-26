import java.util.*;

public class bigints
{
  static Scanner scanner = new Scanner(System.in);
  static class Bigint {
    boolean bigint_sign;
    int bigint_len;
    int[] bigint_chiffres;
  }
  static Bigint read_bigint(int len)
  {
    int[] chiffres = new int[len];
    for (int j = 0 ; j < len; j++)
    {
      char c = scanner.findWithinHorizon(".", 1).charAt(0);
      chiffres[j] = c;
    }
    for (int i = 0 ; i <= (int)((len - 1) / 2); i ++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
    Bigint e = new Bigint();
    e.bigint_sign = true;
    e.bigint_len = len;
    e.bigint_chiffres = chiffres;
    return e;
  }
  
  static void print_bigint(Bigint a)
  {
    if (!a.bigint_sign)
      print((char)'-');
    for (int i = 0 ; i < a.bigint_len; i++)
      print(a.bigint_chiffres[a.bigint_len - 1 - i]);
  }
  
  static boolean bigint_eq(Bigint a, Bigint b)
  {
    /* Renvoie vrai si a = b */
    if (a.bigint_sign != b.bigint_sign)
      return false;
    else if (a.bigint_len != b.bigint_len)
      return false;
    else
    {
      for (int i = 0 ; i < a.bigint_len; i++)
        if (a.bigint_chiffres[i] != b.bigint_chiffres[i])
        return false;
      return true;
    }
  }
  
  static boolean bigint_gt(Bigint a, Bigint b)
  {
    /* Renvoie vrai si a > b */
    if (a.bigint_sign && !b.bigint_sign)
      return true;
    else if (!a.bigint_sign && b.bigint_sign)
      return false;
    else
    {
      if (a.bigint_len > b.bigint_len)
        return a.bigint_sign;
      else if (a.bigint_len < b.bigint_len)
        return !a.bigint_sign;
      else
        for (int i = 0 ; i < a.bigint_len; i++)
        {
          int j = a.bigint_len - 1 - i;
          if (a.bigint_chiffres[j] > b.bigint_chiffres[j])
            return a.bigint_sign;
          else if (a.bigint_chiffres[j] < b.bigint_chiffres[j])
            return !a.bigint_sign;
      }
      return true;
    }
  }
  
  static boolean bigint_lt(Bigint a, Bigint b)
  {
    return !bigint_gt(a, b);
  }
  
  static Bigint add_bigint_positif(Bigint a, Bigint b)
  {
    /* Une addition ou on en a rien a faire des signes */
    int len = Math.max(a.bigint_len, b.bigint_len) + 1;
    int retenue = 0;
    int[] chiffres = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a.bigint_len)
        tmp += a.bigint_chiffres[i];
      if (i < b.bigint_len)
        tmp += b.bigint_chiffres[i];
      retenue = (int)(tmp / 10);
      chiffres[i] = tmp % 10;
    }
    while (len > 0 && chiffres[len - 1] == 0)
      len --;
    Bigint f = new Bigint();
    f.bigint_sign = true;
    f.bigint_len = len;
    f.bigint_chiffres = chiffres;
    return f;
  }
  
  static Bigint sub_bigint_positif(Bigint a, Bigint b)
  {
    /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
    int len = a.bigint_len;
    int retenue = 0;
    int[] chiffres = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = retenue + a.bigint_chiffres[i];
      if (i < b.bigint_len)
        tmp -= b.bigint_chiffres[i];
      if (tmp < 0)
      {
        tmp += 10;
        retenue = -1;
      }
      else
        retenue = 0;
      chiffres[i] = tmp;
    }
    while (len > 0 && chiffres[len - 1] == 0)
      len --;
    Bigint g = new Bigint();
    g.bigint_sign = true;
    g.bigint_len = len;
    g.bigint_chiffres = chiffres;
    return g;
  }
  
  static Bigint neg_bigint(Bigint a)
  {
    Bigint h = new Bigint();
    h.bigint_sign = !a.bigint_sign;
    h.bigint_len = a.bigint_len;
    h.bigint_chiffres = a.bigint_chiffres;
    return h;
  }
  
  static Bigint add_bigint(Bigint a, Bigint b)
  {
    if (a.bigint_sign == b.bigint_sign)
    {
      if (a.bigint_sign)
        return add_bigint_positif(a, b);
      else
        return neg_bigint(add_bigint_positif(a, b));
    }
    else if (a.bigint_sign)
    {
      /* a positif, b negatif */
      if (bigint_gt(a, neg_bigint(b)))
        return sub_bigint_positif(a, b);
      else
        return neg_bigint(sub_bigint_positif(b, a));
    }
    else
    {
      /* a negatif, b positif */
      if (bigint_gt(neg_bigint(a), b))
        return neg_bigint(sub_bigint_positif(a, b));
      else
        return sub_bigint_positif(b, a);
    }
  }
  
  static Bigint sub_bigint(Bigint a, Bigint b)
  {
    return add_bigint(a, neg_bigint(b));
  }
  
  static Bigint mul_bigint_cp(Bigint a, Bigint b)
  {
    /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
    int len = a.bigint_len + b.bigint_len + 1;
    int[] chiffres = new int[len];
    for (int k = 0 ; k < len; k++)
      chiffres[k] = 0;
    for (int i = 0 ; i < a.bigint_len; i++)
    {
      int retenue = 0;
      for (int j = 0 ; j < b.bigint_len; j++)
      {
        chiffres[i + j] = chiffres[i + j] + retenue + b.bigint_chiffres[j] *
        a.bigint_chiffres[i];
        retenue = (int)(chiffres[i + j] / 10);
        chiffres[i + j] = chiffres[i + j] % 10;
      }
      chiffres[i + b.bigint_len] = chiffres[i + b.bigint_len] + retenue;
    }
    chiffres[a.bigint_len + b.bigint_len] =
    (int)(chiffres[a.bigint_len + b.bigint_len - 1] / 10);
    chiffres[a.bigint_len + b.bigint_len - 1] =
    chiffres[a.bigint_len + b.bigint_len - 1] % 10;
    for (int l = 0 ; l <= 2; l ++)
      if (len != 0 && chiffres[len - 1] == 0)
      len --;
    Bigint m = new Bigint();
    m.bigint_sign = a.bigint_sign == b.bigint_sign;
    m.bigint_len = len;
    m.bigint_chiffres = chiffres;
    return m;
  }
  
  static Bigint bigint_premiers_chiffres(Bigint a, int i)
  {
    int len = Math.min(i, a.bigint_len);
    while (len != 0 && a.bigint_chiffres[len - 1] == 0)
      len --;
    Bigint o = new Bigint();
    o.bigint_sign = a.bigint_sign;
    o.bigint_len = len;
    o.bigint_chiffres = a.bigint_chiffres;
    return o;
  }
  
  static Bigint bigint_shift(Bigint a, int i)
  {
    int[] chiffres = new int[a.bigint_len + i];
    for (int k = 0 ; k < a.bigint_len + i; k++)
      if (k >= i)
      chiffres[k] = a.bigint_chiffres[k - i];
    else
      chiffres[k] = 0;
    Bigint p = new Bigint();
    p.bigint_sign = a.bigint_sign;
    p.bigint_len = a.bigint_len + i;
    p.bigint_chiffres = chiffres;
    return p;
  }
  
  static Bigint mul_bigint(Bigint aa, Bigint bb)
  {
    if (aa.bigint_len == 0)
      return aa;
    else if (bb.bigint_len == 0)
      return bb;
    else if (aa.bigint_len < 3 || bb.bigint_len < 3)
      return mul_bigint_cp(aa, bb);
    /* Algorithme de Karatsuba */
    int split = (int)(Math.min(aa.bigint_len, bb.bigint_len) / 2);
    Bigint a = bigint_shift(aa, -split);
    Bigint b = bigint_premiers_chiffres(aa, split);
    Bigint c = bigint_shift(bb, -split);
    Bigint d = bigint_premiers_chiffres(bb, split);
    Bigint amoinsb = sub_bigint(a, b);
    Bigint cmoinsd = sub_bigint(c, d);
    Bigint ac = mul_bigint(a, c);
    Bigint bd = mul_bigint(b, d);
    Bigint amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
    Bigint acdec = bigint_shift(ac, 2 * split);
    return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
    /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
  }
  
  /*
Division,
Modulo
*/
  static int log10(int a)
  {
    int out0 = 1;
    while (a >= 10)
    {
      a /= 10;
      out0 ++;
    }
    return out0;
  }
  
  static Bigint bigint_of_int(int i)
  {
    int size = log10(i);
    if (i == 0)
      size = 0;
    int[] t = new int[size];
    for (int j = 0 ; j < size; j++)
      t[j] = 0;
    for (int k = 0 ; k < size; k++)
    {
      t[k] = i % 10;
      i /= 10;
    }
    Bigint q = new Bigint();
    q.bigint_sign = true;
    q.bigint_len = size;
    q.bigint_chiffres = t;
    return q;
  }
  
  static Bigint fact_bigint(Bigint a)
  {
    Bigint one = bigint_of_int(1);
    Bigint out0 = one;
    while (!bigint_eq(a, one))
    {
      out0 = mul_bigint(a, out0);
      a = sub_bigint(a, one);
    }
    return out0;
  }
  
  static int sum_chiffres_bigint(Bigint a)
  {
    int out0 = 0;
    for (int i = 0 ; i < a.bigint_len; i++)
      out0 += a.bigint_chiffres[i];
    return out0;
  }
  
  /* http://projecteuler.net/problem=20 */
  static int euler20()
  {
    Bigint a = bigint_of_int(15);
    /* normalement c'est 100 */
    a = fact_bigint(a);
    return sum_chiffres_bigint(a);
  }
  
  static Bigint bigint_exp(Bigint a, int b)
  {
    if (b == 1)
      return a;
    else if ((b % 2) == 0)
      return bigint_exp(mul_bigint(a, a), (int)(b / 2));
    else
      return mul_bigint(a, bigint_exp(a, b - 1));
  }
  
  static Bigint bigint_exp_10chiffres(Bigint a, int b)
  {
    a = bigint_premiers_chiffres(a, 10);
    if (b == 1)
      return a;
    else if ((b % 2) == 0)
      return bigint_exp_10chiffres(mul_bigint(a, a), (int)(b / 2));
    else
      return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
  }
  
  static void euler48()
  {
    Bigint sum = bigint_of_int(0);
    for (int i = 1 ; i <= 100; i ++)
    {
      /* 1000 normalement */
      Bigint ib = bigint_of_int(i);
      Bigint ibeib = bigint_exp_10chiffres(ib, i);
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
    }
    print("euler 48 = ");
    print_bigint(sum);
    print("\n");
  }
  
  static int euler16()
  {
    Bigint a = bigint_of_int(2);
    a = bigint_exp(a, 100);
    /* 1000 normalement */
    return sum_chiffres_bigint(a);
  }
  
  static int euler25()
  {
    int i = 2;
    Bigint a = bigint_of_int(1);
    Bigint b = bigint_of_int(1);
    while (b.bigint_len < 100)
    {
      /* 1000 normalement */
      Bigint c = add_bigint(a, b);
      a = b;
      b = c;
      i ++;
    }
    return i;
  }
  
  static int euler29()
  {
    int maxA = 5;
    int maxB = 5;
    Bigint[] a_bigint = new Bigint[maxA + 1];
    for (int j = 0 ; j < maxA + 1; j++)
      a_bigint[j] = bigint_of_int(j * j);
    Bigint[] a0_bigint = new Bigint[maxA + 1];
    for (int j2 = 0 ; j2 < maxA + 1; j2++)
      a0_bigint[j2] = bigint_of_int(j2);
    int[] b = new int[maxA + 1];
    for (int k = 0 ; k < maxA + 1; k++)
      b[k] = 2;
    int n = 0;
    boolean found = true;
    while (found)
    {
      Bigint min0 = a0_bigint[0];
      found = false;
      for (int i = 2 ; i <= maxA; i ++)
        if (b[i] <= maxB)
      {
        if (found)
        {
          if (bigint_lt(a_bigint[i], min0))
            min0 = a_bigint[i];
        }
        else
        {
          min0 = a_bigint[i];
          found = true;
        }
      }
      if (found)
      {
        n ++;
        for (int l = 2 ; l <= maxA; l ++)
          if (bigint_eq(a_bigint[l], min0) && b[l] <= maxB)
        {
          b[l] = b[l] + 1;
          a_bigint[l] = mul_bigint(a_bigint[l], a0_bigint[l]);
        }
      }
    }
    return n;
  }
  
  
  static void main(String[] args)
  {
    System.out.printf("%s\n", euler29());
    Bigint sum = read_bigint(50);
    for (int i = 2 ; i <= 100; i ++)
    {
      scanner.findWithinHorizon("[\n\r ]*", 1);
      Bigint tmp = read_bigint(50);
      sum = add_bigint(sum, tmp);
    }
    print("euler13 = ");
    print_bigint(sum);
    System.out.printf("\neuler25 = %s\neuler16 = %s\n", euler25(), euler16());
    euler48();
    System.out.printf("euler20 = %s\n", euler20());
    Bigint a = bigint_of_int(999999);
    Bigint b = bigint_of_int(9951263);
    print_bigint(a);
    print(">>1=");
    print_bigint(bigint_shift(a, -1));
    print("\n");
    print_bigint(a);
    print("*");
    print_bigint(b);
    print("=");
    print_bigint(mul_bigint(a, b));
    print("\n");
    print_bigint(a);
    print("*");
    print_bigint(b);
    print("=");
    print_bigint(mul_bigint_cp(a, b));
    print("\n");
    print_bigint(a);
    print("+");
    print_bigint(b);
    print("=");
    print_bigint(add_bigint(a, b));
    print("\n");
    print_bigint(b);
    print("-");
    print_bigint(a);
    print("=");
    print_bigint(sub_bigint(b, a));
    print("\n");
    print_bigint(a);
    print("-");
    print_bigint(b);
    print("=");
    print_bigint(sub_bigint(a, b));
    print("\n");
    print_bigint(a);
    print(">");
    print_bigint(b);
    print("=");
    boolean r = bigint_gt(a, b);
    if (r)
      print("True");
    else
      print("False");
    print("\n");
  }
  
}

