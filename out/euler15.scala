object euler15
{
  
  
  def main(args : Array[String])
  {
    var n: Int = 10;
    /* normalement on doit mettre 20 mais là on se tape un overflow */
    n = n + 1;
    var tab :Array[Array[Int]] = new Array[Array[Int]](n);
    for (i <- 0 to n - 1)
    {
        var tab2 :Array[Int] = new Array[Int](n);
        for (j <- 0 to n - 1)
          tab2(j) = 0;
        tab(i) = tab2;
    }
    for (l <- 0 to n - 1)
    {
        tab(n - 1)(l) = 1;
        tab(l)(n - 1) = 1;
    }
    for (o <- 2 to n)
    {
        var r: Int = n - o;
        for (p <- 2 to n)
        {
            var q: Int = n - p;
            tab(r)(q) = tab(r + 1)(q) + tab(r)(q + 1);
        }
    }
    for (m <- 0 to n - 1)
    {
        for (k <- 0 to n - 1)
          printf("%d ", tab(m)(k));
        printf("\n");
    }
    printf("%d\n", tab(0)(0));
  }
  
}

