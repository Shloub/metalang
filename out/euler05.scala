object euler05
{
  
  def max2_(a : Int, b : Int): Int = {
    if (a > b)
      return a;
    else
      return b;
  }
  
  def primesfactors(_n : Int): Array[Int] = {
    var n = _n;
    var i: Int=0;
    var tab :Array[Int] = new Array[Int](n + 1);
    for (i <- 0 to n + 1 - 1)
      tab(i) = 0;
    var d: Int = 2;
    while (n != 1 && d * d <= n)
      if ((n % d) == 0)
    {
      tab(d) = tab(d) + 1;
      n = n / d;
    }
    else
      d = d + 1;
    tab(n) = tab(n) + 1;
    return tab;
  }
  
  
  def main(args : Array[String])
  {
    var lim: Int = 20;
    var o :Array[Int] = new Array[Int](lim + 1);
    for (m <- 0 to lim + 1 - 1)
      o(m) = 0;
    for (i <- 1 to lim)
    {
      var t: Array[Int] = primesfactors(i);
      for (j <- 1 to i)
        o(j) = max2_(o(j), t(j));
    }
    var product: Int = 1;
    for (k <- 1 to lim)
      for (l <- 1 to o(k))
        product = product * k;
    printf("%d\n", product);
  }
  
}

