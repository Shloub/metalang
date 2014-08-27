package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}


func max2(a int, b int) int{
  if a > b {
    return a
  } else {
    return b
  }
}

func min2(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}


type bigint struct {
  bigint_sign bool;
  bigint_len int;
  bigint_chiffres []int;
}

func read_bigint(len int) * bigint{
  var chiffres []int = make([]int, len)
  for j := 0 ; j <= len - 1; j++ {
    var c byte
    fmt.Fscanf(reader, "%c", &c)
      chiffres[j] = (int)(c);
  }
  for i := 0 ; i <= (len - 1) / 2; i++ {
    var tmp int = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
  }
  var o * bigint = new (bigint)
  (*o).bigint_sign=true;
  (*o).bigint_len=len;
  (*o).bigint_chiffres=chiffres;
  return o
}

func print_bigint(a * bigint) {
  if !(*a).bigint_sign {
    fmt.Printf("%c", '-');
  }
  for i := 0 ; i <= (*a).bigint_len - 1; i++ {
    fmt.Printf("%d", (*a).bigint_chiffres[(*a).bigint_len - 1 - i]);
  }
}

func bigint_eq(a * bigint, b * bigint) bool{
  /* Renvoie vrai si a = b */
  if (*a).bigint_sign != (*b).bigint_sign {
    return false
  } else if (*a).bigint_len != (*b).bigint_len {
    return false
  } else {
    for i := 0 ; i <= (*a).bigint_len - 1; i++ {
      if (*a).bigint_chiffres[i] != (*b).bigint_chiffres[i] {
          return false
        }
    }
    return true
  } 
}

func bigint_gt(a * bigint, b * bigint) bool{
  /* Renvoie vrai si a > b */
  if (*a).bigint_sign && !(*b).bigint_sign {
    return true
  } else if !(*a).bigint_sign && (*b).bigint_sign {
    return false
  } else {
    if (*a).bigint_len > (*b).bigint_len {
      return (*a).bigint_sign
    } else if (*a).bigint_len < (*b).bigint_len {
      return !(*a).bigint_sign
    } else {
      for i := 0 ; i <= (*a).bigint_len - 1; i++ {
        var j int = (*a).bigint_len - 1 - i
          if (*a).bigint_chiffres[j] > (*b).bigint_chiffres[j] {
            return (*a).bigint_sign
          } else if (*a).bigint_chiffres[j] < (*b).bigint_chiffres[j] {
            return !(*a).bigint_sign
          } 
      }
    } 
    return true
  } 
}

func bigint_lt(a * bigint, b * bigint) bool{
  return !bigint_gt(a, b)
}

func add_bigint_positif(a * bigint, b * bigint) * bigint{
  /* Une addition ou on en a rien a faire des signes */
  var len int = max2((*a).bigint_len, (*b).bigint_len) + 1
  var retenue int = 0
  var chiffres []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var tmp int = retenue
      if i < (*a).bigint_len {
        tmp += (*a).bigint_chiffres[i];
      }
      if i < (*b).bigint_len {
        tmp += (*b).bigint_chiffres[i];
      }
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
  }
  for len > 0 && chiffres[len - 1] == 0{
                                         len --;
  }
  var p * bigint = new (bigint)
  (*p).bigint_sign=true;
  (*p).bigint_len=len;
  (*p).bigint_chiffres=chiffres;
  return p
}

func sub_bigint_positif(a * bigint, b * bigint) * bigint{
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  var len int = (*a).bigint_len
  var retenue int = 0
  var chiffres []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var tmp int = retenue + (*a).bigint_chiffres[i]
      if i < (*b).bigint_len {
        tmp -= (*b).bigint_chiffres[i];
      }
      if tmp < 0 {
        tmp += 10;
          retenue = -1;
      } else {
        retenue = 0;
      }
      chiffres[i] = tmp;
  }
  for len > 0 && chiffres[len - 1] == 0{
                                         len --;
  }
  var q * bigint = new (bigint)
  (*q).bigint_sign=true;
  (*q).bigint_len=len;
  (*q).bigint_chiffres=chiffres;
  return q
}

func neg_bigint(a * bigint) * bigint{
  var r * bigint = new (bigint)
  (*r).bigint_sign=!(*a).bigint_sign;
  (*r).bigint_len=(*a).bigint_len;
  (*r).bigint_chiffres=(*a).bigint_chiffres;
  return r
}

func add_bigint(a * bigint, b * bigint) * bigint{
  if (*a).bigint_sign == (*b).bigint_sign {
    if (*a).bigint_sign {
        return add_bigint_positif(a, b)
      } else {
        return neg_bigint(add_bigint_positif(a, b))
      }
  } else if (*a).bigint_sign {
    /* a positif, b negatif */
      if bigint_gt(a, neg_bigint(b)) {
        return sub_bigint_positif(a, b)
      } else {
        return neg_bigint(sub_bigint_positif(b, a))
      }
  } else {
    /* a negatif, b positif */
    if bigint_gt(neg_bigint(a), b) {
      return neg_bigint(sub_bigint_positif(a, b))
    } else {
      return sub_bigint_positif(b, a)
    }
  } 
}

func sub_bigint(a * bigint, b * bigint) * bigint{
  return add_bigint(a, neg_bigint(b))
}

func mul_bigint_cp(a * bigint, b * bigint) * bigint{
  /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
  var len int = (*a).bigint_len + (*b).bigint_len + 1
  var chiffres []int = make([]int, len)
  for k := 0 ; k <= len - 1; k++ {
    chiffres[k] = 0;
  }
  for i := 0 ; i <= (*a).bigint_len - 1; i++ {
    var retenue int = 0
      for j := 0 ; j <= (*b).bigint_len - 1; j++ {
        chiffres[i + j] = chiffres[i + j] + retenue + (*b).bigint_chiffres[j] * (*a).bigint_chiffres[i];
          retenue = chiffres[i + j] / 10;
          chiffres[i + j] = chiffres[i + j] % 10;
      }
      chiffres[i + (*b).bigint_len] = chiffres[i + (*b).bigint_len] + retenue;
  }
  chiffres[(*a).bigint_len + (*b).bigint_len] = chiffres[(*a).bigint_len + (*b).bigint_len - 1] / 10;
  chiffres[(*a).bigint_len + (*b).bigint_len - 1] = chiffres[(*a).bigint_len + (*b).bigint_len - 1] % 10;
  for l := 0 ; l <= 2; l++ {
    if len != 0 && chiffres[len - 1] == 0 {
        len --;
      }
  }
  var s * bigint = new (bigint)
  (*s).bigint_sign=(*a).bigint_sign == (*b).bigint_sign;
  (*s).bigint_len=len;
  (*s).bigint_chiffres=chiffres;
  return s
}

func bigint_premiers_chiffres(a * bigint, i int) * bigint{
  var len int = min2(i, (*a).bigint_len)
  for len != 0 && (*a).bigint_chiffres[len - 1] == 0{
                                                      len --;
  }
  var u * bigint = new (bigint)
  (*u).bigint_sign=(*a).bigint_sign;
  (*u).bigint_len=len;
  (*u).bigint_chiffres=(*a).bigint_chiffres;
  return u
}

func bigint_shift(a * bigint, i int) * bigint{
  var chiffres []int = make([]int, ((*a).bigint_len + i))
  for k := 0 ; k <= (*a).bigint_len + i - 1; k++ {
    if k >= i {
        chiffres[k] = (*a).bigint_chiffres[k - i];
      } else {
        chiffres[k] = 0;
      }
  }
  var v * bigint = new (bigint)
  (*v).bigint_sign=(*a).bigint_sign;
  (*v).bigint_len=(*a).bigint_len + i;
  (*v).bigint_chiffres=chiffres;
  return v
}

func mul_bigint(aa * bigint, bb * bigint) * bigint{
  if (*aa).bigint_len == 0 {
    return aa
  } else if (*bb).bigint_len == 0 {
    return bb
  } else if (*aa).bigint_len < 3 || (*bb).bigint_len < 3 {
    return mul_bigint_cp(aa, bb)
  }  
  /* Algorithme de Karatsuba */
  var split int = min2((*aa).bigint_len, (*bb).bigint_len) / 2
  var a * bigint = bigint_shift(aa, -split)
  var b * bigint = bigint_premiers_chiffres(aa, split)
  var c * bigint = bigint_shift(bb, -split)
  var d * bigint = bigint_premiers_chiffres(bb, split)
  var amoinsb * bigint = sub_bigint(a, b)
  var cmoinsd * bigint = sub_bigint(c, d)
  var ac * bigint = mul_bigint(a, c)
  var bd * bigint = mul_bigint(b, d)
  var amoinsbcmoinsd * bigint = mul_bigint(amoinsb, cmoinsd)
  var acdec * bigint = bigint_shift(ac, 2 * split)
  return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split))
  /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
}

/*
Division,
Modulo
*/
func log10(a int) int{
  var out_ int = 1
  for a >= 10{
               a /= 10;
               out_ ++;
  }
  return out_
}

func bigint_of_int(i int) * bigint{
  var size int = log10(i)
  if i == 0 {
    size = 0;
  }
  var t []int = make([]int, size)
  for j := 0 ; j <= size - 1; j++ {
    t[j] = 0;
  }
  for k := 0 ; k <= size - 1; k++ {
    t[k] = i % 10;
      i /= 10;
  }
  var w * bigint = new (bigint)
  (*w).bigint_sign=true;
  (*w).bigint_len=size;
  (*w).bigint_chiffres=t;
  return w
}

func fact_bigint(a * bigint) * bigint{
  var one * bigint = bigint_of_int(1)
  var out_ * bigint = one
  for !bigint_eq(a, one){
                          out_ = mul_bigint(a, out_);
                          a = sub_bigint(a, one);
  }
  return out_
}

func sum_chiffres_bigint(a * bigint) int{
  var out_ int = 0
  for i := 0 ; i <= (*a).bigint_len - 1; i++ {
    out_ += (*a).bigint_chiffres[i];
  }
  return out_
}

/* http://projecteuler.net/problem=20 */
func euler20() int{
  var a * bigint = bigint_of_int(15)
  /* normalement c'est 100 */
  a = fact_bigint(a);
  return sum_chiffres_bigint(a)
}

func bigint_exp(a * bigint, b int) * bigint{
  if b == 1 {
    return a
  } else if (b % 2) == 0 {
    return bigint_exp(mul_bigint(a, a), b / 2)
  } else {
    return mul_bigint(a, bigint_exp(a, b - 1))
  } 
}

func bigint_exp_10chiffres(a * bigint, b int) * bigint{
  a = bigint_premiers_chiffres(a, 10);
  if b == 1 {
    return a
  } else if (b % 2) == 0 {
    return bigint_exp_10chiffres(mul_bigint(a, a), b / 2)
  } else {
    return mul_bigint(a, bigint_exp_10chiffres(a, b - 1))
  } 
}

func euler48() {
  var sum * bigint = bigint_of_int(0)
  for i := 1 ; i <= 100; i++ {
    /* 1000 normalement */
      var ib * bigint = bigint_of_int(i)
      var ibeib * bigint = bigint_exp_10chiffres(ib, i)
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
  }
  fmt.Printf("euler 48 = ");
  print_bigint(sum);
  fmt.Printf("\n");
}

func euler16() int{
  var a * bigint = bigint_of_int(2)
  a = bigint_exp(a, 100);
  /* 1000 normalement */
  return sum_chiffres_bigint(a)
}

func euler25() int{
  var i int = 2
  var a * bigint = bigint_of_int(1)
  var b * bigint = bigint_of_int(1)
  for (*b).bigint_len < 100{
                             /* 1000 normalement */
                             var c * bigint = add_bigint(a, b)
                             a = b;
                             b = c;
                             i ++;
  }
  return i
}

func euler29() int{
  var maxA int = 5
  var maxB int = 5
  var a_bigint []* bigint = make([]* bigint, (maxA + 1))
  for j := 0 ; j <= maxA + 1 - 1; j++ {
    a_bigint[j] = bigint_of_int(j * j);
  }
  var a0_bigint []* bigint = make([]* bigint, (maxA + 1))
  for j2 := 0 ; j2 <= maxA + 1 - 1; j2++ {
    a0_bigint[j2] = bigint_of_int(j2);
  }
  var b []int = make([]int, (maxA + 1))
  for k := 0 ; k <= maxA + 1 - 1; k++ {
    b[k] = 2;
  }
  var n int = 0
  var found bool = true
  for found{
             var min_ * bigint = a0_bigint[0]
             found = false;
             for i := 2 ; i <= maxA; i++ {
               if b[i] <= maxB {
                   if found {
                       if bigint_lt(a_bigint[i], min_) {
                           min_ = a_bigint[i];
                         }
                     } else {
                       min_ = a_bigint[i];
                       found = true;
                     }
                 }
             }
             if found {
               n ++;
                 for l := 2 ; l <= maxA; l++ {
                   if bigint_eq(a_bigint[l], min_) && b[l] <= maxB {
                       b[l] = b[l] + 1;
                         a_bigint[l] = mul_bigint(a_bigint[l], a0_bigint[l]);
                     }
                 }
             }
  }
  return n
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  fmt.Printf("%d\n", euler29());
  var sum * bigint = read_bigint(50)
  for i := 2 ; i <= 100; i++ {
    skip()
      var tmp * bigint = read_bigint(50)
      sum = add_bigint(sum, tmp);
  }
  fmt.Printf("euler13 = ");
  print_bigint(sum);
  fmt.Printf("\neuler25 = %d\neuler16 = %d\n", euler25(), euler16());
  euler48();
  fmt.Printf("euler20 = %d\n", euler20());
  var a * bigint = bigint_of_int(999999)
  var b * bigint = bigint_of_int(9951263)
  print_bigint(a);
  fmt.Printf(">>1=");
  print_bigint(bigint_shift(a, -1));
  fmt.Printf("\n");
  print_bigint(a);
  fmt.Printf("*");
  print_bigint(b);
  fmt.Printf("=");
  print_bigint(mul_bigint(a, b));
  fmt.Printf("\n");
  print_bigint(a);
  fmt.Printf("*");
  print_bigint(b);
  fmt.Printf("=");
  print_bigint(mul_bigint_cp(a, b));
  fmt.Printf("\n");
  print_bigint(a);
  fmt.Printf("+");
  print_bigint(b);
  fmt.Printf("=");
  print_bigint(add_bigint(a, b));
  fmt.Printf("\n");
  print_bigint(b);
  fmt.Printf("-");
  print_bigint(a);
  fmt.Printf("=");
  print_bigint(sub_bigint(b, a));
  fmt.Printf("\n");
  print_bigint(a);
  fmt.Printf("-");
  print_bigint(b);
  fmt.Printf("=");
  print_bigint(sub_bigint(a, b));
  fmt.Printf("\n");
  print_bigint(a);
  fmt.Printf(">");
  print_bigint(b);
  fmt.Printf("=");
  var m bool = bigint_gt(a, b)
  if m {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

