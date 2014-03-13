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
    bigint out_ = new bigint();
    out_.bigint_sign = sign == (char)43;
    out_.bigint_len = len;
    out_.bigint_chiffres = chiffres;
    return out_;
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
            return a.bigint_sign;
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
    if (chiffres[len - 1] == 0)
      len --;
    bigint out_ = new bigint();
    out_.bigint_sign = true;
    out_.bigint_len = len;
    out_.bigint_chiffres = chiffres;
    return out_;
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
    bigint out_ = new bigint();
    out_.bigint_sign = true;
    out_.bigint_len = len;
    out_.bigint_chiffres = chiffres;
    return out_;
  }
  
  public static bigint neg_bigint(bigint a)
  {
    bigint out_ = new bigint();
    out_.bigint_sign = !a.bigint_sign;
    out_.bigint_len = a.bigint_len;
    out_.bigint_chiffres = a.bigint_chiffres;
    return out_;
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
      if (chiffres[len - 1] == 0)
      len --;
    bigint out_ = new bigint();
    out_.bigint_sign = a.bigint_sign == b.bigint_sign;
    out_.bigint_len = len;
    out_.bigint_chiffres = chiffres;
    return out_;
  }
  
  public static bigint bigint_premiers_chiffres(bigint a, int i)
  {
    bigint out_ = new bigint();
    out_.bigint_sign = a.bigint_sign;
    out_.bigint_len = i;
    out_.bigint_chiffres = a.bigint_chiffres;
    return out_;
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
    bigint out_ = new bigint();
    out_.bigint_sign = a.bigint_sign;
    out_.bigint_len = a.bigint_len + i;
    out_.bigint_chiffres = chiffres;
    return out_;
  }
  
  public static bigint mul_bigint(bigint aa, bigint bb)
  {
    if (aa.bigint_len < 3 || bb.bigint_len < 3)
      return mul_bigint_cp(aa, bb);
    /* Algorithme de Karatsuba */
    int split = max2(aa.bigint_len, bb.bigint_len) / 2;
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
TODO multiplication plus rapide
Division,
Modulo
Exp
*/
  
  public static void Main(String[] args)
  {
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
    bool g = bigint_gt(a, b);
    if (g)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
  }
  
}

