object euler10
{
  
  def eratostene(t : Array[Int], max0 : Int): Int = {
    var sum: Int = 0;
    for (i <- 2 to max0 - 1)
    
        if (t(i) == i)
        {
            sum = sum + i;
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
    return sum;
  }
  
  
  def main(args : Array[String])
  {
    var n: Int = 100000;
    /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
    var t :Array[Int] = new Array[Int](n);
    for (i <- 0 to n - 1)
    
        t(i) = i;
    t(1) = 0;
    printf("%d\n", eratostene(t, n));
  }
  
}

