object euler50
{
  
  def min2_0(a : Int, b : Int): Int = {
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
    for (i_0 <- 0 to nprimes - 1)
      sum(i_0) = primes(i_0);
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
              stop = min2_0(stop, i);
        }
        len = len + 1;
    }
    printf("%d\n%d\n", resp, maxl);
  }
  
}

