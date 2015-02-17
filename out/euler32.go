package main
import "fmt"
/*
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
*/
func okdigits(ok []bool, n int) bool{
  if n == 0 {
    return true
  } else {
    var digit int = n % 10
    if ok[digit] {
      ok[digit] = false;
        var o bool = okdigits(ok, n / 10)
        ok[digit] = true;
        return o
    } else {
      return false
    }
  }
}

func main() {
  var count int = 0
  var allowed []bool = make([]bool, 10)
  for i := 0 ; i <= 10 - 1; i++ {
    allowed[i] = i != 0;
  }
  var counted []bool = make([]bool, 100000)
  for j := 0 ; j <= 100000 - 1; j++ {
    counted[j] = false;
  }
  for e := 1 ; e <= 9; e++ {
    allowed[e] = false;
      for b := 1 ; b <= 9; b++ {
        if allowed[b] {
            allowed[b] = false;
              var be int = (b * e) % 10
              if allowed[be] {
                allowed[be] = false;
                  for a := 1 ; a <= 9; a++ {
                    if allowed[a] {
                        allowed[a] = false;
                          for c := 1 ; c <= 9; c++ {
                            if allowed[c] {
                                allowed[c] = false;
                                  for d := 1 ; d <= 9; d++ {
                                    if allowed[d] {
                                        allowed[d] = false;
                                          /* 2 * 3 digits */
                                          var product int = (a * 10 + b) * (c *
                                                                    100 + d *
                                                                    10 + e)
                                          if !counted[product] && okdigits(allowed, product / 10) {
                                            counted[product] = true;
                                              count += product;
                                              fmt.Printf("%d ", product);
                                          }
                                          /* 1  * 4 digits */
                                          var product2 int = b * (a * 1000 +
                                                                   c * 100 +
                                                                   d * 10 + e)
                                          if !counted[product2] && okdigits(allowed, product2 / 10) {
                                            counted[product2] = true;
                                              count += product2;
                                              fmt.Printf("%d ", product2);
                                          }
                                          allowed[d] = true;
                                      }
                                  }
                                  allowed[c] = true;
                              }
                          }
                          allowed[a] = true;
                      }
                  }
                  allowed[be] = true;
              }
              allowed[b] = true;
          }
      }
      allowed[e] = true;
  }
  fmt.Printf("%d\n", count);
}

