object euler50
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

  def min2_(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  def eratostene(t : Array[Int], max0 : Int): Int = {
    var i: Int=0;
    var n: Int = 0;
    for (i <- 2 to max0 - 1)
      if (t(i) == i)
    {
      n = n + 1;
      if (max0 / i > i)
      {
        var j: Int = i * i;
        while (j < max0 && j > 0)
        {
          t(j) = 0;
          j = j + i;
        }
      }
    }
    return n;
  }
  
  
  def main(args : Array[String])
  {
    var maximumprimes: Int = 1000001;
    var era :Array[Int] = new Array[Int](maximumprimes);
    for (j <- 0 to maximumprimes - 1)
      era(j) = j;
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
    var sum :Array[Int] = new Array[Int](nprimes);
    for (i_U <- 0 to nprimes - 1)
      sum(i_U) = primes(i_U);
    var maxl: Int = 0;
    var process: Boolean = true;
    var stop: Int = maximumprimes - 1;
    var len: Int = 1;
    var resp: Int = 1;
    while (process)
    {
      process = false;
      for (i <- 0 to stop)
        if (i + len < nprimes)
      {
        sum(i) = sum(i) + primes(i + len);
        if (maximumprimes > sum(i))
        {
          process = true;
          if (era(sum(i)) == sum(i))
          {
            maxl = len;
            resp = sum(i);
          }
        }
        else
          stop = min2_(stop, i);
      }
      len = len + 1;
    }
    printf("%d\n%d\n", resp, maxl);
  }
  
}

