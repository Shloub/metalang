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
  }
  return b
}


type bigint struct {
  bigint_sign bool;
  bigint_len int;
  bigint_chiffres []int;
}

func read_bigint() * bigint{
  var len int = 0
  fmt.Fscanf(reader, "%d", &len);
  skip()
  var sign byte = '_'
  fmt.Fscanf(reader, "%c", &sign);
  skip()
  var chiffres []int = make([]int, len)
  for d := 0 ; d <= len - 1; d++ {
    var c byte = '_'
      fmt.Fscanf(reader, "%c", &c);
      chiffres[d] = (int)(c) - (int)('0');
  }
  for i := 0 ; i <= (len - 1) / 2; i++ {
    var tmp int = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
  }
  skip()
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=sign == '+';
  (*out_).bigint_len=len;
  (*out_).bigint_chiffres=chiffres;
  return out_
}

func print_bigint(a * bigint) {
  if !(*a).bigint_sign {
    fmt.Printf("%c", '-');
  }
  for i := 0 ; i <= (*a).bigint_len - 1; i++ {
    var e int = (*a).bigint_chiffres[(*a).bigint_len - 1 - i]
      fmt.Printf("%d", e);
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
            return (*a).bigint_sign
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
  if chiffres[len - 1] == 0 {
    len --;
  }
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=true;
  (*out_).bigint_len=len;
  (*out_).bigint_chiffres=chiffres;
  return out_
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
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=true;
  (*out_).bigint_len=len;
  (*out_).bigint_chiffres=chiffres;
  return out_
}

func neg_bigint(a * bigint) * bigint{
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=!(*a).bigint_sign;
  (*out_).bigint_len=(*a).bigint_len;
  (*out_).bigint_chiffres=(*a).bigint_chiffres;
  return out_
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
    if chiffres[len - 1] == 0 {
        len --;
      }
  }
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=(*a).bigint_sign == (*b).bigint_sign;
  (*out_).bigint_len=len;
  (*out_).bigint_chiffres=chiffres;
  return out_
}

func bigint_premiers_chiffres(a * bigint, i int) * bigint{
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=(*a).bigint_sign;
  (*out_).bigint_len=i;
  (*out_).bigint_chiffres=(*a).bigint_chiffres;
  return out_
}

func bigint_shift(a * bigint, i int) * bigint{
  var f int = (*a).bigint_len + i
  var chiffres []int = make([]int, f)
  for k := 0 ; k <= f - 1; k++ {
    if k >= i {
        chiffres[k] = (*a).bigint_chiffres[k - i];
      } else {
        chiffres[k] = 0;
      }
  }
  var out_ * bigint = new (bigint)
  (*out_).bigint_sign=(*a).bigint_sign;
  (*out_).bigint_len=(*a).bigint_len + i;
  (*out_).bigint_chiffres=chiffres;
  return out_
}

func mul_bigint(aa * bigint, bb * bigint) * bigint{
  if (*aa).bigint_len < 3 || (*bb).bigint_len < 3 {
    return mul_bigint_cp(aa, bb)
  }
  /* Algorithme de Karatsuba */
  var split int = max2((*aa).bigint_len, (*bb).bigint_len) / 2
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
TODO multiplication plus rapide
Division,
Modulo
Exp
*/
func main() {
  reader = bufio.NewReader(os.Stdin)
  var a * bigint = read_bigint()
  var b * bigint = read_bigint()
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
  var g bool = bigint_gt(a, b)
  if g {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

