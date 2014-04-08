using System;

public class bigints
{
static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
public static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}
public static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
  
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public static int min2(int a, int b)
  {
    if (a < b)
      return a;
    return b;
  }
  
  public class bigint {public bool bigint_sign;public int bigint_len;public int[] bigint_chiffres;}
  public static bigint read_bigint()
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    char sign = '_';
    sign = readChar();
    stdin_sep();
    int[] chiffres = new int[len];
    for (int d = 0 ; d < len; d++)
    {
      char c = '_';
      c = readChar();
      chiffres[d] = c - '0';
    }
    for (int i = 0 ; i <= (len - 1) / 2; i ++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
    stdin_sep();
    bigint m = new bigint();
    m.bigint_sign = sign == (char)43;
    m.bigint_len = len;
    m.bigint_chiffres = chiffres;
    return m;
  }
  
  public static void print_bigint(bigint a)
  {
    if (!a.bigint_sign)
      Console.Write('-');
    for (int i = 0 ; i < a.bigint_len; i++)
    {
      int e = a.bigint_chiffres[a.bigint_len - 1 - i];
      Console.Write(e);
    }
  }
  
  public static bool bigint_eq(bigint a, bigint b)
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
  
  public static bool bigint_gt(bigint a, bigint b)
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
  
  public static bool bigint_lt(bigint a, bigint b)
  {
    return !bigint_gt(a, b);
  }
  
  public static bigint add_bigint_positif(bigint a, bigint b)
  {
    /* Une addition ou on en a rien a faire des signes */
    int len = max2(a.bigint_len, b.bigint_len) + 1;
    int retenue = 0;
    int[] chiffres = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a.bigint_len)
        tmp += a.bigint_chiffres[i];
      if (i < b.bigint_len)
        tmp += b.bigint_chiffres[i];
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    }
    while (len > 0 && chiffres[len - 1] == 0)
      len --;
    bigint n = new bigint();
    n.bigint_sign = true;
    n.bigint_len = len;
    n.bigint_chiffres = chiffres;
    return n;
  }
  
  public static bigint sub_bigint_positif(bigint a, bigint b)
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
    bigint o = new bigint();
    o.bigint_sign = true;
    o.bigint_len = len;
    o.bigint_chiffres = chiffres;
    return o;
  }
  
  public static bigint neg_bigint(bigint a)
  {
    bigint p = new bigint();
    p.bigint_sign = !a.bigint_sign;
    p.bigint_len = a.bigint_len;
    p.bigint_chiffres = a.bigint_chiffres;
    return p;
  }
  
  public static bigint add_bigint(bigint a, bigint b)
  {
    if (a.bigint_sign == b.bigint_sign)
      if (a.bigint_sign)
      return add_bigint_positif(a, b);
    else
      return neg_bigint(add_bigint_positif(a, b));
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
  
  public static bigint sub_bigint(bigint a, bigint b)
  {
    return add_bigint(a, neg_bigint(b));
  }
  
  public static bigint mul_bigint_cp(bigint a, bigint b)
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
        chiffres[i + j] = chiffres[i + j] + retenue + b.bigint_chiffres[j] * a.bigint_chiffres[i];
        retenue = chiffres[i + j] / 10;
        chiffres[i + j] = chiffres[i + j] % 10;
      }
      chiffres[i + b.bigint_len] = chiffres[i + b.bigint_len] + retenue;
    }
    chiffres[a.bigint_len + b.bigint_len] = chiffres[a.bigint_len + b.bigint_len - 1] / 10;
    chiffres[a.bigint_len + b.bigint_len - 1] = chiffres[a.bigint_len + b.bigint_len - 1] % 10;
    for (int l = 0 ; l <= 2; l ++)
      if (len != 0 && chiffres[len - 1] == 0)
      len --;
    bigint q = new bigint();
    q.bigint_sign = a.bigint_sign == b.bigint_sign;
    q.bigint_len = len;
    q.bigint_chiffres = chiffres;
    return q;
  }
  
  public static bigint bigint_premiers_chiffres(bigint a, int i)
  {
    int len = min2(i, a.bigint_len);
    while (len != 0 && a.bigint_chiffres[len - 1] == 0)
      len --;
    bigint r = new bigint();
    r.bigint_sign = a.bigint_sign;
    r.bigint_len = len;
    r.bigint_chiffres = a.bigint_chiffres;
    return r;
  }
  
  public static bigint bigint_shift(bigint a, int i)
  {
    int f = a.bigint_len + i;
    int[] chiffres = new int[f];
    for (int k = 0 ; k < f; k++)
      if (k >= i)
      chiffres[k] = a.bigint_chiffres[k - i];
    else
      chiffres[k] = 0;
    bigint s = new bigint();
    s.bigint_sign = a.bigint_sign;
    s.bigint_len = a.bigint_len + i;
    s.bigint_chiffres = chiffres;
    return s;
  }
  
  public static bigint mul_bigint(bigint aa, bigint bb)
  {
    if (aa.bigint_len == 0)
      return aa;
    else if (bb.bigint_len == 0)
      return bb;
    else if (aa.bigint_len < 3 || bb.bigint_len < 3)
      return mul_bigint_cp(aa, bb);
    /* Algorithme de Karatsuba */
    int split = min2(aa.bigint_len, bb.bigint_len) / 2;
    bigint a = bigint_shift(aa, -split);
    bigint b = bigint_premiers_chiffres(aa, split);
    bigint c = bigint_shift(bb, -split);
    bigint d = bigint_premiers_chiffres(bb, split);
    bigint amoinsb = sub_bigint(a, b);
    bigint cmoinsd = sub_bigint(c, d);
    bigint ac = mul_bigint(a, c);
    bigint bd = mul_bigint(b, d);
    bigint amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
    bigint acdec = bigint_shift(ac, 2 * split);
    return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
    /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
  }
  
  /*
Division,
Modulo
*/
  public static int log10(int a)
  {
    int out_ = 1;
    while (a >= 10)
    {
      a /= 10;
      out_ ++;
    }
    return out_;
  }
  
  public static bigint bigint_of_int(int i)
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
    bigint u = new bigint();
    u.bigint_sign = true;
    u.bigint_len = size;
    u.bigint_chiffres = t;
    return u;
  }
  
  public static bigint fact_bigint(bigint a)
  {
    bigint one = bigint_of_int(1);
    bigint out_ = one;
    while (!bigint_eq(a, one))
    {
      out_ = mul_bigint(a, out_);
      a = sub_bigint(a, one);
    }
    return out_;
  }
  
  public static int sum_chiffres_bigint(bigint a)
  {
    int out_ = 0;
    for (int i = 0 ; i < a.bigint_len; i++)
      out_ += a.bigint_chiffres[i];
    return out_;
  }
  
  /* http://projecteuler.net/problem=20 */
  public static int euler20()
  {
    bigint a = bigint_of_int(100);
    a = fact_bigint(a);
    return sum_chiffres_bigint(a);
  }
  
  public static bigint bigint_exp_10chiffres(bigint a, int b)
  {
    a = bigint_premiers_chiffres(a, 10);
    if (b == 1)
      return a;
    else if ((b % 2) == 0)
      return bigint_exp_10chiffres(mul_bigint(a, a), b / 2);
    else
      return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
  }
  
  public static void euler48()
  {
    bigint sum = bigint_of_int(0);
    for (int i = 1 ; i <= 1000; i ++)
    {
      bigint ib = bigint_of_int(i);
      bigint ibeib = bigint_exp_10chiffres(ib, i);
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
    }
    Console.Write("euler 48 = ");
    print_bigint(sum);
    Console.Write("\n");
  }
  
  
  public static void Main(String[] args)
  {
    euler48();
    Console.Write("euler20 = ");
    int g = euler20();
    Console.Write(g);
    Console.Write("\n");
    bigint a = read_bigint();
    bigint b = read_bigint();
    print_bigint(a);
    Console.Write(">>1=");
    print_bigint(bigint_shift(a, -1));
    Console.Write("\n");
    print_bigint(a);
    Console.Write("*");
    print_bigint(b);
    Console.Write("=");
    print_bigint(mul_bigint(a, b));
    Console.Write("\n");
    print_bigint(a);
    Console.Write("*");
    print_bigint(b);
    Console.Write("=");
    print_bigint(mul_bigint_cp(a, b));
    Console.Write("\n");
    print_bigint(a);
    Console.Write("+");
    print_bigint(b);
    Console.Write("=");
    print_bigint(add_bigint(a, b));
    Console.Write("\n");
    print_bigint(b);
    Console.Write("-");
    print_bigint(a);
    Console.Write("=");
    print_bigint(sub_bigint(b, a));
    Console.Write("\n");
    print_bigint(a);
    Console.Write("-");
    print_bigint(b);
    Console.Write("=");
    print_bigint(sub_bigint(a, b));
    Console.Write("\n");
    print_bigint(a);
    Console.Write(">");
    print_bigint(b);
    Console.Write("=");
    bool h = bigint_gt(a, b);
    if (h)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
  }
  
}

