object euler46
{
  
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
    var maximumprimes: Int = 6000;
    var era :Array[Int] = new Array[Int](maximumprimes);
    for (j_0 <- 0 to maximumprimes - 1)
      era(j_0) = j_0;
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
    var canbe :Array[Boolean] = new Array[Boolean](maximumprimes);
    for (i_0 <- 0 to maximumprimes - 1)
      canbe(i_0) = false;
    for (i <- 0 to nprimes - 1)
      for (j <- 0 to maximumprimes - 1)
      {
        var n: Int = primes(i) + 2 * j * j;
        if (n < maximumprimes)
          canbe(n) = true;
      }
    for (m <- 1 to maximumprimes)
    {
      var m2: Int = m * 2 + 1;
      if (m2 < maximumprimes && !canbe(m2))
      {
        printf("%d\n", m2);
      }
    }
  }
  
}

