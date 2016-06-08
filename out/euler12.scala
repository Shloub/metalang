object euler12
{
  
  def max2_0(a : Int, b : Int): Int = {
    if (a > b)
        return a;
    else
        return b;
  }
  
  def eratostene(t : Array[Int], max0 : Int): Int = {
    var n: Int = 0;
    for (i <- 2 to max0 - 1)
        if (t(i) == i)
        {
            var j: Int = i * i;
            n = n + 1;
            while (j < max0 && j > 0)
            {
                t(j) = 0;
                j = j + i;
            }
        }
    return n;
  }
  
  def fillPrimesFactors(t : Array[Int], _n : Int, primes : Array[Int], nprimes : Int): Int = {
    var n = _n;
    for (i <- 0 to nprimes - 1)
    {
        var d: Int = primes(i);
        while (n % d == 0)
        {
            t(d) = t(d) + 1;
            n = n / d;
        }
        if (n == 1)
            return primes(i);
    }
    return n;
  }
  
  def find(ndiv2 : Int): Int = {
    var maximumprimes: Int = 110;
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
    for (n <- 1 to 10000)
    {
        var primesFactors :Array[Int] = new Array[Int](n + 2);
        for (m <- 0 to n + 2 - 1)
            primesFactors(m) = 0;
        var max0: Int = max2_0(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
        primesFactors(2) = primesFactors(2) - 1;
        var ndivs: Int = 1;
        for (i <- 0 to max0)
            if (primesFactors(i) != 0)
                ndivs = ndivs * (1 + primesFactors(i));
        if (ndivs > ndiv2)
            return n * (n + 1) / 2;
        /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
    }
    return 0;
  }
  
  
  def main(args : Array[String])
  {
    printf("%d\n", find(500));
  }
  
}

