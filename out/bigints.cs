using System;

public class bigints
{
static bool eof;
static String buffer;
static char readChar_(){
  if (buffer == null || buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = tmp + "\n";
  }
  char c = buffer[0];
  return c;
}
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
static void stdin_sep(){
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
  public class bigint {
    public bool bigint_sign;
    public int bigint_len;
    public int[] bigint_chiffres;
  }
  static bigint read_bigint(int len)
  {
    int[] chiffres = new int[len];
    for (int j = 0; j < len; j += 1)
    {
        char c = readChar();
        chiffres[j] = (int)(c);
    }
    for (int i = 0; i <= (len - 1) / 2; i += 1)
    {
        int tmp = chiffres[i];
        chiffres[i] = chiffres[len - 1 - i];
        chiffres[len - 1 - i] = tmp;
    }
    bigint e = new bigint();
    e.bigint_sign = true;
    e.bigint_len = len;
    e.bigint_chiffres = chiffres;
    return e;
  }
  
  static void print_bigint(bigint a)
  {
    if (!a.bigint_sign)
        Console.Write('-');
    for (int i = 0; i < a.bigint_len; i += 1)
        Console.Write(a.bigint_chiffres[a.bigint_len - 1 - i]);
  }
  
  static bool bigint_eq(bigint a, bigint b)
  {
    /* Renvoie vrai si a = b */
    if (a.bigint_sign != b.bigint_sign)
        return false;
    else if (a.bigint_len != b.bigint_len)
        return false;
    else
    {
        for (int i = 0; i < a.bigint_len; i += 1)
            if (a.bigint_chiffres[i] != b.bigint_chiffres[i])
                return false;
        return true;
    }
  }
  
  static bool bigint_gt(bigint a, bigint b)
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
            for (int i = 0; i < a.bigint_len; i += 1)
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
  
  static bool bigint_lt(bigint a, bigint b)
  {
    return !bigint_gt(a, b);
  }
  
  static bigint add_bigint_positif(bigint a, bigint b)
  {
    /* Une addition ou on en a rien a faire des signes */
    int len = Math.Max(a.bigint_len, b.bigint_len) + 1;
    int retenue = 0;
    int[] chiffres = new int[len];
    for (int i = 0; i < len; i += 1)
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
        len -= 1;
    bigint f = new bigint();
    f.bigint_sign = true;
    f.bigint_len = len;
    f.bigint_chiffres = chiffres;
    return f;
  }
  
  static bigint sub_bigint_positif(bigint a, bigint b)
  {
    /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
    int len = a.bigint_len;
    int retenue = 0;
    int[] chiffres = new int[len];
    for (int i = 0; i < len; i += 1)
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
        len -= 1;
    bigint g = new bigint();
    g.bigint_sign = true;
    g.bigint_len = len;
    g.bigint_chiffres = chiffres;
    return g;
  }
  
  static bigint neg_bigint(bigint a)
  {
    bigint h = new bigint();
    h.bigint_sign = !a.bigint_sign;
    h.bigint_len = a.bigint_len;
    h.bigint_chiffres = a.bigint_chiffres;
    return h;
  }
  
  static bigint add_bigint(bigint a, bigint b)
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
        /* a negatif, b positif */
        if (bigint_gt(neg_bigint(a), b))
            return neg_bigint(sub_bigint_positif(a, b));
        else
            return sub_bigint_positif(b, a);
  }
  
  static bigint sub_bigint(bigint a, bigint b)
  {
    return add_bigint(a, neg_bigint(b));
  }
  
  static bigint mul_bigint_cp(bigint a, bigint b)
  {
    /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
    int len = a.bigint_len + b.bigint_len + 1;
    int[] chiffres = new int[len];
    for (int k = 0; k < len; k += 1)
        chiffres[k] = 0;
    for (int i = 0; i < a.bigint_len; i += 1)
    {
        int retenue = 0;
        for (int j = 0; j < b.bigint_len; j += 1)
        {
            chiffres[i + j] += retenue + b.bigint_chiffres[j] * a.bigint_chiffres[i];
            retenue = chiffres[i + j] / 10;
            chiffres[i + j] = chiffres[i + j] % 10;
        }
        chiffres[i + b.bigint_len] += retenue;
    }
    chiffres[a.bigint_len + b.bigint_len] = chiffres[a.bigint_len + b.bigint_len - 1] / 10;
    chiffres[a.bigint_len + b.bigint_len - 1] = chiffres[a.bigint_len + b.bigint_len - 1] % 10;
    for (int l = 0; l < 3; l += 1)
        if (len != 0 && chiffres[len - 1] == 0)
            len -= 1;
    bigint m = new bigint();
    m.bigint_sign = a.bigint_sign == b.bigint_sign;
    m.bigint_len = len;
    m.bigint_chiffres = chiffres;
    return m;
  }
  
  static bigint bigint_premiers_chiffres(bigint a, int i)
  {
    int len = Math.Min(i, a.bigint_len);
    while (len != 0 && a.bigint_chiffres[len - 1] == 0)
        len -= 1;
    bigint o = new bigint();
    o.bigint_sign = a.bigint_sign;
    o.bigint_len = len;
    o.bigint_chiffres = a.bigint_chiffres;
    return o;
  }
  
  static bigint bigint_shift(bigint a, int i)
  {
    int[] chiffres = new int[a.bigint_len + i];
    for (int k = 0; k < a.bigint_len + i; k += 1)
        if (k >= i)
            chiffres[k] = a.bigint_chiffres[k - i];
        else
            chiffres[k] = 0;
    bigint p = new bigint();
    p.bigint_sign = a.bigint_sign;
    p.bigint_len = a.bigint_len + i;
    p.bigint_chiffres = chiffres;
    return p;
  }
  
  static bigint mul_bigint(bigint aa, bigint bb)
  {
    if (aa.bigint_len == 0)
        return aa;
    else if (bb.bigint_len == 0)
        return bb;
    else if (aa.bigint_len < 3 || bb.bigint_len < 3)
        return mul_bigint_cp(aa, bb);
    /* Algorithme de Karatsuba */
    int split = Math.Min(aa.bigint_len, bb.bigint_len) / 2;
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
  static int log10(int a)
  {
    int out0 = 1;
    while (a >= 10)
    {
        a /= 10;
        out0 += 1;
    }
    return out0;
  }
  
  static bigint bigint_of_int(int i)
  {
    int size = log10(i);
    if (i == 0)
        size = 0;
    int[] t = new int[size];
    for (int j = 0; j < size; j += 1)
        t[j] = 0;
    for (int k = 0; k < size; k += 1)
    {
        t[k] = i % 10;
        i /= 10;
    }
    bigint q = new bigint();
    q.bigint_sign = true;
    q.bigint_len = size;
    q.bigint_chiffres = t;
    return q;
  }
  
  static bigint fact_bigint(bigint a)
  {
    bigint one = bigint_of_int(1);
    bigint out0 = one;
    while (!bigint_eq(a, one))
    {
        out0 = mul_bigint(a, out0);
        a = sub_bigint(a, one);
    }
    return out0;
  }
  
  static int sum_chiffres_bigint(bigint a)
  {
    int out0 = 0;
    for (int i = 0; i < a.bigint_len; i += 1)
        out0 += a.bigint_chiffres[i];
    return out0;
  }
  
  /* http://projecteuler.net/problem=20 */
  static int euler20()
  {
    bigint a = bigint_of_int(15);
    /* normalement c'est 100 */
    a = fact_bigint(a);
    return sum_chiffres_bigint(a);
  }
  
  static bigint bigint_exp(bigint a, int b)
  {
    if (b == 1)
        return a;
    else if (b % 2 == 0)
        return bigint_exp(mul_bigint(a, a), b / 2);
    else
        return mul_bigint(a, bigint_exp(a, b - 1));
  }
  
  static bigint bigint_exp_10chiffres(bigint a, int b)
  {
    a = bigint_premiers_chiffres(a, 10);
    if (b == 1)
        return a;
    else if (b % 2 == 0)
        return bigint_exp_10chiffres(mul_bigint(a, a), b / 2);
    else
        return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
  }
  
  static void euler48()
  {
    bigint sum = bigint_of_int(0);
    for (int i = 1; i < 101; i += 1)
    {
        /* 1000 normalement */
        bigint ib = bigint_of_int(i);
        bigint ibeib = bigint_exp_10chiffres(ib, i);
        sum = add_bigint(sum, ibeib);
        sum = bigint_premiers_chiffres(sum, 10);
    }
    Console.Write("euler 48 = ");
    print_bigint(sum);
    Console.Write("\n");
  }
  
  static int euler16()
  {
    bigint a = bigint_of_int(2);
    a = bigint_exp(a, 100);
    /* 1000 normalement */
    return sum_chiffres_bigint(a);
  }
  
  static int euler25()
  {
    int i = 2;
    bigint a = bigint_of_int(1);
    bigint b = bigint_of_int(1);
    while (b.bigint_len < 100)
    {
        /* 1000 normalement */
        bigint c = add_bigint(a, b);
        a = b;
        b = c;
        i += 1;
    }
    return i;
  }
  
  static int euler29()
  {
    int maxA = 5;
    int maxB = 5;
    bigint[] a_bigint = new bigint[maxA + 1];
    for (int j = 0; j <= maxA; j += 1)
        a_bigint[j] = bigint_of_int(j * j);
    bigint[] a0_bigint = new bigint[maxA + 1];
    for (int j2 = 0; j2 <= maxA; j2 += 1)
        a0_bigint[j2] = bigint_of_int(j2);
    int[] b = new int[maxA + 1];
    for (int k = 0; k <= maxA; k += 1)
        b[k] = 2;
    int n = 0;
    bool found = true;
    while (found)
    {
        bigint min0 = a0_bigint[0];
        found = false;
        for (int i = 2; i <= maxA; i += 1)
            if (b[i] <= maxB)
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
        if (found)
        {
            n += 1;
            for (int l = 2; l <= maxA; l += 1)
                if (bigint_eq(a_bigint[l], min0) && b[l] <= maxB)
                {
                    b[l] += 1;
                    a_bigint[l] = mul_bigint(a_bigint[l], a0_bigint[l]);
                }
        }
    }
    return n;
  }
  
  
  public static void Main(String[] args)
  {
    Console.Write(euler29() + "\n");
    bigint sum = read_bigint(50);
    for (int i = 2; i < 101; i += 1)
    {
        stdin_sep();
        bigint tmp = read_bigint(50);
        sum = add_bigint(sum, tmp);
    }
    Console.Write("euler13 = ");
    print_bigint(sum);
    Console.Write("\neuler25 = " + euler25() + "\neuler16 = " + euler16() + "\n");
    euler48();
    Console.Write("euler20 = " + euler20() + "\n");
    bigint a = bigint_of_int(999999);
    bigint b = bigint_of_int(9951263);
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
    if (bigint_gt(a, b))
        Console.Write("True");
    else
        Console.Write("False");
    Console.Write("\n");
  }
  
}

