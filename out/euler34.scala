object euler34
{
  
  
  def main(args : Array[String])
  {
    var f :Array[Int] = new Array[Int](10);
    for (j <- 0 to 10 - 1)
      f(j) = 1;
    for (i <- 1 to 9)
    {
      f(i) = f(i) * i * f(i - 1);
      printf("%d ", f(i));
    }
    var out0: Int = 0;
    printf("\n");
    for (a <- 0 to 9)
      for (b <- 0 to 9)
        for (c <- 0 to 9)
          for (d <- 0 to 9)
            for (e <- 0 to 9)
              for (g <- 0 to 9)
              {
                var sum: Int = f(a) + f(b) + f(c) + f(d) + f(e) + f(g);
                var num: Int = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                if (a == 0)
                {
                  sum = sum - 1;
                  if (b == 0)
                  {
                    sum = sum - 1;
                    if (c == 0)
                    {
                      sum = sum - 1;
                      if (d == 0)
                        sum = sum - 1;
                    }
                  }
                }
                if (sum == num && sum != 1 && sum != 2)
                {
                  out0 = out0 + num;
                  printf("%d ", num);
                }
              }
    printf("\n%d\n", out0);
  }
  
}

