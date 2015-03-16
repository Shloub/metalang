object euler27
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

  def eratostene(t : Array[Int], max0 : Int): Int = {
    var i: Int=0;
    var n: Int = 0;
    for (i <- 2 to max0 - 1)
      if (t(i) == i)
    {
      n = n + 1;
      var j: Int = i * i;
      while (j < max0 && j > 0)
      {
        t(j) = 0;
        j = j + i;
      }
    }
    return n;
  }
  
  def isPrime(_n : Int, primes : Array[Int], len : Int): Boolean = {
    var n = _n;
    var i: Int = 0;
    if (n < 0)
      n = -n;
    while (primes(i) * primes(i) < n)
    {
      if ((n % primes(i)) == 0)
        return false;
      i = i + 1;
    }
    return true;
  }
  
  def test(a : Int, b : Int, primes : Array[Int], len : Int): Int = {
    var n: Int=0;
    for (n <- 0 to 200)
    {
      var j: Int = n * n + a * n + b;
      if (!isPrime(j, primes, len))
        return n;
    }
    return 200;
  }
  
  
  def main(args : Array[String])
  {
    var maximumprimes: Int = 1000;
    var era :Array[Int] = new Array[Int](maximumprimes);
    for (j <- 0 to maximumprimes - 1)
      era(j) = j;
    var result: Int = 0;
    var max0: Int = 0;
    var nprimes: Int = eratostene(era, maximumprimes);
    var primes :Array[Int] = new Array[Int](nprimes);
    for (o <- 0 to nprimes - 1)
      primes(o) = 0;
    var l: Int = 0;
    for (k <- 2 to maximumprimes - 1)
      if (era(k) == k)
    {
      primes(l) = k;
      l = l + 1;
    }
    printf("%d == %d\n", l, nprimes);
    var ma: Int = 0;
    var mb: Int = 0;
    for (b <- 3 to 999)
      if (era(b) == b)
      for (a <- -999 to 999)
      {
        var n1: Int = test(a, b, primes, nprimes);
        var n2: Int = test(a, -b, primes, nprimes);
        if (n1 > max0)
        {
          max0 = n1;
          result = a * b;
          ma = a;
          mb = b;
        }
        if (n2 > max0)
        {
          max0 = n2;
          result = -a * b;
          ma = a;
          mb = -b;
        }
      }
    printf("%d %d\n%d\n%d\n", ma, mb, max0, result);
  }
  
}

