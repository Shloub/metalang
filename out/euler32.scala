object euler32
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
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
  def okdigits(ok : Array[Boolean], n : Int): Boolean = {
    if (n == 0)
      return true;
    else
    {
      var digit: Int = n % 10;
      if (ok(digit))
      {
        ok(digit) = false;
        var o: Boolean = okdigits(ok, n / 10);
        ok(digit) = true;
        return o;
      }
      else
        return false;
    }
  }
  
  
  def main(args : Array[String])
  {
    var count: Int = 0;
    var allowed :Array[Boolean] = new Array[Boolean](10);
    for (i <- 0 to 10 - 1)
      allowed(i) = i != 0;
    var counted :Array[Boolean] = new Array[Boolean](100000);
    for (j <- 0 to 100000 - 1)
      counted(j) = false;
    for (e <- 1 to 9)
    {
      allowed(e) = false;
      for (b <- 1 to 9)
        if (allowed(b))
      {
        allowed(b) = false;
        var be: Int = (b * e) % 10;
        if (allowed(be))
        {
          allowed(be) = false;
          for (a <- 1 to 9)
            if (allowed(a))
          {
            allowed(a) = false;
            for (c <- 1 to 9)
              if (allowed(c))
            {
              allowed(c) = false;
              for (d <- 1 to 9)
                if (allowed(d))
              {
                allowed(d) = false;
                /* 2 * 3 digits */
                var product: Int = (a * 10 + b) * (c * 100 + d * 10 + e);
                if (!counted(product) && okdigits(allowed, product / 10))
                {
                  counted(product) = true;
                  count = count + product;
                  printf("%d ", product);
                }
                /* 1  * 4 digits */
                var product2: Int = b * (a * 1000 + c * 100 + d * 10 + e);
                if (!counted(product2) && okdigits(allowed, product2 / 10))
                {
                  counted(product2) = true;
                  count = count + product2;
                  printf("%d ", product2);
                }
                allowed(d) = true;
              }
              allowed(c) = true;
            }
            allowed(a) = true;
          }
          allowed(be) = true;
        }
        allowed(b) = true;
      }
      allowed(e) = true;
    }
    printf("%d\n", count);
  }
  
}

