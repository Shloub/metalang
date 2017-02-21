object euler24
{
  
  def fact(n : Int): Int = {
    var prod: Int = 1;
    for (i <- 2 to n)
        prod = prod * i;
    return prod;
  }
  
  def show(lim : Int, _nth : Int){
    var nth = _nth;var t :Array[Int] = new Array[Int](lim);
    for (i <- 0 to lim - 1)
        t(i) = i;
    var pris :Array[Boolean] = new Array[Boolean](lim);
    for (j <- 0 to lim - 1)
        pris(j) = false;
    for (k <- 1 to lim - 1)
    {
        var n: Int = fact(lim - k);
        var nchiffre: Int = nth / n;
        nth = nth % n;
        for (l <- 0 to lim - 1)
            if (!pris(l))
            {
                if (nchiffre == 0)
                {
                    printf("%d", l);
                    pris(l) = true;
                }
                nchiffre = nchiffre - 1;
            }
    }
    for (m <- 0 to lim - 1)
        if (!pris(m))
            printf("%d", m);
    printf("\n");
  }
  
  
  def main(args : Array[String])
  {
    show(10, 999999);
  }
  
}

