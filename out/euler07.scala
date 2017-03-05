object euler07
{
  
  def divisible(n : Int, t : Array[Int], size : Int): Boolean = {
    for (i <- 0 to size - 1)
        if (n % t(i) == 0)
            return true;
    return false;
  }
  
  def find(_n : Int, t : Array[Int], _used : Int, nth : Int): Int = {
    var n = _n;
    var used = _used;while (used != nth)
        if (divisible(n, t, used))
            n = n + 1;
        else
        {
            t(used) = n;
            n = n + 1;
            used = used + 1;
        }
    return t(used - 1);
  }
  
  def main(args : Array[String])
  {
    var n: Int = 10001;
    var t :Array[Int] = new Array[Int](n);
    for (i <- 0 to n - 1)
        t(i) = 2;
    printf("%d\n", find(3, t, 1, n));
  }
  
}

