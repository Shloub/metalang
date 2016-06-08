object bigints
{
  
var buffer = "";
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}
  
  def max2_0(a : Int, b : Int): Int = {
    if (a > b)
        return a;
    else
        return b;
  }
  
  def min2_0(a : Int, b : Int): Int = {
    if (a < b)
        return a;
    else
        return b;
  }
  
  class Bigint(_bigint_sign: Boolean, _bigint_len: Int, _bigint_chiffres: Array[Int]){
    var bigint_sign: Boolean=_bigint_sign;
    var bigint_len: Int=_bigint_len;
    var bigint_chiffres: Array[Int]=_bigint_chiffres;
  }
  
  def read_bigint(len : Int): Bigint = {
    var chiffres :Array[Int] = new Array[Int](len);
    for (j <- 0 to len - 1)
    {
        var c = read_char();
        chiffres(j) = (c).toInt;
    }
    for (i <- 0 to (len - 1) / 2)
    {
        var tmp: Int = chiffres(i);
        chiffres(i) = chiffres(len - 1 - i);
        chiffres(len - 1 - i) = tmp;
    }
    return new Bigint(true, len, chiffres);
  }
  
  def print_bigint(a : Bigint){
    if (!a.bigint_sign)
        printf("%c", '-');
    for (i <- 0 to a.bigint_len - 1)
        printf("%d", a.bigint_chiffres(a.bigint_len - 1 - i));
  }
  
  def bigint_eq(a : Bigint, b : Bigint): Boolean = {
    /* Renvoie vrai si a = b */
    if (a.bigint_sign != b.bigint_sign)
        return false;
    else
        if (a.bigint_len != b.bigint_len)
            return false;
        else
        {
            for (i <- 0 to a.bigint_len - 1)
                if (a.bigint_chiffres(i) != b.bigint_chiffres(i))
                    return false;
            return true;
        }
  }
  
  def bigint_gt(a : Bigint, b : Bigint): Boolean = {
    /* Renvoie vrai si a > b */
    if (a.bigint_sign && !b.bigint_sign)
        return true;
    else
        if (!a.bigint_sign && b.bigint_sign)
            return false;
        else
        {
            if (a.bigint_len > b.bigint_len)
                return a.bigint_sign;
            else
                if (a.bigint_len < b.bigint_len)
                    return !a.bigint_sign;
                else
                    for (i <- 0 to a.bigint_len - 1)
                    {
                        var j: Int = a.bigint_len - 1 - i;
                        if (a.bigint_chiffres(j) > b.bigint_chiffres(j))
                            return a.bigint_sign;
                        else
                            if (a.bigint_chiffres(j) < b.bigint_chiffres(j))
                                return !a.bigint_sign;
                    }
            return true;
        }
  }
  
  def bigint_lt(a : Bigint, b : Bigint): Boolean = {
    return !bigint_gt(a, b);
  }
  
  def add_bigint_positif(a : Bigint, b : Bigint): Bigint = {
    /* Une addition ou on en a rien a faire des signes */
    var len: Int = max2_0(a.bigint_len, b.bigint_len) + 1;
    var retenue: Int = 0;
    var chiffres :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    {
        var tmp: Int = retenue;
        if (i < a.bigint_len)
            tmp = tmp + a.bigint_chiffres(i);
        if (i < b.bigint_len)
            tmp = tmp + b.bigint_chiffres(i);
        retenue = tmp / 10;
        chiffres(i) = tmp % 10;
    }
    while (len > 0 && chiffres(len - 1) == 0)
        len = len - 1;
    return new Bigint(true, len, chiffres);
  }
  
  def sub_bigint_positif(a : Bigint, b : Bigint): Bigint = {
    /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
    var len: Int = a.bigint_len;
    var retenue: Int = 0;
    var chiffres :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    {
        var tmp: Int = retenue + a.bigint_chiffres(i);
        if (i < b.bigint_len)
            tmp = tmp - b.bigint_chiffres(i);
        if (tmp < 0)
        {
            tmp = tmp + 10;
            retenue = -1;
        }
        else
            retenue = 0;
        chiffres(i) = tmp;
    }
    while (len > 0 && chiffres(len - 1) == 0)
        len = len - 1;
    return new Bigint(true, len, chiffres);
  }
  
  def neg_bigint(a : Bigint): Bigint = {
    return new Bigint(!a.bigint_sign, a.bigint_len, a.bigint_chiffres);
  }
  
  def add_bigint(a : Bigint, b : Bigint): Bigint = {
    if (a.bigint_sign == b.bigint_sign)
        if (a.bigint_sign)
            return add_bigint_positif(a, b);
        else
            return neg_bigint(add_bigint_positif(a, b));
    else
        if (a.bigint_sign)
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
  
  def sub_bigint(a : Bigint, b : Bigint): Bigint = {
    return add_bigint(a, neg_bigint(b));
  }
  
  def mul_bigint_cp(a : Bigint, b : Bigint): Bigint = {
    /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
    var len: Int = a.bigint_len + b.bigint_len + 1;
    var chiffres :Array[Int] = new Array[Int](len);
    for (k <- 0 to len - 1)
        chiffres(k) = 0;
    for (i <- 0 to a.bigint_len - 1)
    {
        var retenue: Int = 0;
        for (j <- 0 to b.bigint_len - 1)
        {
            chiffres(i + j) = chiffres(i + j) + retenue + b.bigint_chiffres(j) * a.bigint_chiffres(i);
            retenue = chiffres(i + j) / 10;
            chiffres(i + j) = chiffres(i + j) % 10;
        }
        chiffres(i + b.bigint_len) = chiffres(i + b.bigint_len) + retenue;
    }
    chiffres(a.bigint_len + b.bigint_len) = chiffres(a.bigint_len + b.bigint_len - 1) / 10;
    chiffres(a.bigint_len + b.bigint_len - 1) = chiffres(a.bigint_len + b.bigint_len - 1) % 10;
    for (l <- 0 to 2)
        if (len != 0 && chiffres(len - 1) == 0)
            len = len - 1;
    return new Bigint(a.bigint_sign == b.bigint_sign, len, chiffres);
  }
  
  def bigint_premiers_chiffres(a : Bigint, i : Int): Bigint = {
    var len: Int = min2_0(i, a.bigint_len);
    while (len != 0 && a.bigint_chiffres(len - 1) == 0)
        len = len - 1;
    return new Bigint(a.bigint_sign, len, a.bigint_chiffres);
  }
  
  def bigint_shift(a : Bigint, i : Int): Bigint = {
    var chiffres :Array[Int] = new Array[Int](a.bigint_len + i);
    for (k <- 0 to a.bigint_len + i - 1)
        if (k >= i)
            chiffres(k) = a.bigint_chiffres(k - i);
        else
            chiffres(k) = 0;
    return new Bigint(a.bigint_sign, a.bigint_len + i, chiffres);
  }
  
  def mul_bigint(aa : Bigint, bb : Bigint): Bigint = {
    if (aa.bigint_len == 0)
        return aa;
    else
        if (bb.bigint_len == 0)
            return bb;
        else
            if (aa.bigint_len < 3 || bb.bigint_len < 3)
                return mul_bigint_cp(aa, bb);
    /* Algorithme de Karatsuba */
    var split: Int = min2_0(aa.bigint_len, bb.bigint_len) / 2;
    var a: Bigint = bigint_shift(aa, -split);
    var b: Bigint = bigint_premiers_chiffres(aa, split);
    var c: Bigint = bigint_shift(bb, -split);
    var d: Bigint = bigint_premiers_chiffres(bb, split);
    var amoinsb: Bigint = sub_bigint(a, b);
    var cmoinsd: Bigint = sub_bigint(c, d);
    var ac: Bigint = mul_bigint(a, c);
    var bd: Bigint = mul_bigint(b, d);
    var amoinsbcmoinsd: Bigint = mul_bigint(amoinsb, cmoinsd);
    var acdec: Bigint = bigint_shift(ac, 2 * split);
    return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
    /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
  }
  
  /*
Division,
Modulo
*/
  def log10(_a : Int): Int = {
    var a = _a;
    var out0: Int = 1;
    while (a >= 10)
    {
        a = a / 10;
        out0 = out0 + 1;
    }
    return out0;
  }
  
  def bigint_of_int(_i : Int): Bigint = {
    var i = _i;
    var size: Int = log10(i);
    if (i == 0)
        size = 0;
    var t :Array[Int] = new Array[Int](size);
    for (j <- 0 to size - 1)
        t(j) = 0;
    for (k <- 0 to size - 1)
    {
        t(k) = i % 10;
        i = i / 10;
    }
    return new Bigint(true, size, t);
  }
  
  def fact_bigint(_a : Bigint): Bigint = {
    var a = _a;
    var one: Bigint = bigint_of_int(1);
    var out0: Bigint = one;
    while (!bigint_eq(a, one))
    {
        out0 = mul_bigint(a, out0);
        a = sub_bigint(a, one);
    }
    return out0;
  }
  
  def sum_chiffres_bigint(a : Bigint): Int = {
    var out0: Int = 0;
    for (i <- 0 to a.bigint_len - 1)
        out0 = out0 + a.bigint_chiffres(i);
    return out0;
  }
  
  /* http://projecteuler.net/problem=20 */
  def euler20(): Int = {
    var a: Bigint = bigint_of_int(15);
    /* normalement c'est 100 */
    a = fact_bigint(a);
    return sum_chiffres_bigint(a);
  }
  
  def bigint_exp(a : Bigint, b : Int): Bigint = {
    if (b == 1)
        return a;
    else
        if (b % 2 == 0)
            return bigint_exp(mul_bigint(a, a), b / 2);
        else
            return mul_bigint(a, bigint_exp(a, b - 1));
  }
  
  def bigint_exp_10chiffres(_a : Bigint, b : Int): Bigint = {
    var a = _a;
    a = bigint_premiers_chiffres(a, 10);
    if (b == 1)
        return a;
    else
        if (b % 2 == 0)
            return bigint_exp_10chiffres(mul_bigint(a, a), b / 2);
        else
            return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
  }
  
  def euler48(){
    var sum: Bigint = bigint_of_int(0);
    for (i <- 1 to 100)
    {
        /* 1000 normalement */
        var ib: Bigint = bigint_of_int(i);
        var ibeib: Bigint = bigint_exp_10chiffres(ib, i);
        sum = add_bigint(sum, ibeib);
        sum = bigint_premiers_chiffres(sum, 10);
    }
    printf("euler 48 = ");
    print_bigint(sum);
    printf("\n");
  }
  
  def euler16(): Int = {
    var a: Bigint = bigint_of_int(2);
    a = bigint_exp(a, 100);
    /* 1000 normalement */
    return sum_chiffres_bigint(a);
  }
  
  def euler25(): Int = {
    var i: Int = 2;
    var a: Bigint = bigint_of_int(1);
    var b: Bigint = bigint_of_int(1);
    while (b.bigint_len < 100)
    {
        /* 1000 normalement */
        var c: Bigint = add_bigint(a, b);
        a = b;
        b = c;
        i = i + 1;
    }
    return i;
  }
  
  def euler29(): Int = {
    var maxA: Int = 5;
    var maxB: Int = 5;
    var a_bigint :Array[Bigint] = new Array[Bigint](maxA + 1);
    for (j <- 0 to maxA + 1 - 1)
        a_bigint(j) = bigint_of_int(j * j);
    var a0_bigint :Array[Bigint] = new Array[Bigint](maxA + 1);
    for (j2 <- 0 to maxA + 1 - 1)
        a0_bigint(j2) = bigint_of_int(j2);
    var b :Array[Int] = new Array[Int](maxA + 1);
    for (k <- 0 to maxA + 1 - 1)
        b(k) = 2;
    var n: Int = 0;
    var found: Boolean = true;
    while (found)
    {
        var min0: Bigint = a0_bigint(0);
        found = false;
        for (i <- 2 to maxA)
            if (b(i) <= maxB)
                if (found)
                {
                    if (bigint_lt(a_bigint(i), min0))
                        min0 = a_bigint(i);
                }
                else
                {
                    min0 = a_bigint(i);
                    found = true;
                }
        if (found)
        {
            n = n + 1;
            for (l <- 2 to maxA)
                if (bigint_eq(a_bigint(l), min0) && b(l) <= maxB)
                {
                    b(l) = b(l) + 1;
                    a_bigint(l) = mul_bigint(a_bigint(l), a0_bigint(l));
                }
        }
    }
    return n;
  }
  
  
  def main(args : Array[String])
  {
    printf("%d\n", euler29());
    var sum: Bigint = read_bigint(50);
    for (i <- 2 to 100)
    {
        skip();
        var tmp: Bigint = read_bigint(50);
        sum = add_bigint(sum, tmp);
    }
    printf("euler13 = ");
    print_bigint(sum);
    printf("\neuler25 = %d\neuler16 = %d\n", euler25(), euler16());
    euler48();
    printf("euler20 = %d\n", euler20());
    var a: Bigint = bigint_of_int(999999);
    var b: Bigint = bigint_of_int(9951263);
    print_bigint(a);
    printf(">>1=");
    print_bigint(bigint_shift(a, -1));
    printf("\n");
    print_bigint(a);
    printf("*");
    print_bigint(b);
    printf("=");
    print_bigint(mul_bigint(a, b));
    printf("\n");
    print_bigint(a);
    printf("*");
    print_bigint(b);
    printf("=");
    print_bigint(mul_bigint_cp(a, b));
    printf("\n");
    print_bigint(a);
    printf("+");
    print_bigint(b);
    printf("=");
    print_bigint(add_bigint(a, b));
    printf("\n");
    print_bigint(b);
    printf("-");
    print_bigint(a);
    printf("=");
    print_bigint(sub_bigint(b, a));
    printf("\n");
    print_bigint(a);
    printf("-");
    print_bigint(b);
    printf("=");
    print_bigint(sub_bigint(a, b));
    printf("\n");
    print_bigint(a);
    printf(">");
    print_bigint(b);
    printf("=");
    if (bigint_gt(a, b))
        printf("True");
    else
        printf("False");
    printf("\n");
  }
  
}

