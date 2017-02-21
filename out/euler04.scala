object euler04
{
  
  def max2_0(a : Int, b : Int): Int = {
    if (a > b)
        return a;
    else
        return b;
  }
  
  /*

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

*/
  def chiffre(c : Int, m : Int): Int = {
    if (c == 0)
        return m % 10;
    else
        return chiffre(c - 1, m / 10);
  }
  
  
  def main(args : Array[String])
  {
    var m: Int = 1;
    for (a <- 0 to 9)
        for (f <- 1 to 9)
            for (d <- 0 to 9)
                for (c <- 1 to 9)
                    for (b <- 0 to 9)
                        for (e <- 0 to 9)
                        {
                            var mul: Int = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f;
                            if (chiffre(0, mul) == chiffre(5, mul) && chiffre(1, mul) == chiffre(4, mul) && chiffre(2, mul) == chiffre(3, mul))
                                m = max2_0(mul, m);
                        }
    printf("%d\n", m);
  }
  
}

