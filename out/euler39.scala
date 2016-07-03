object euler39
{
  
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](1001);
    for (i <- 0 to 1000)
        t(i) = 0;
    for (a <- 1 to 1000)
        for (b <- 1 to 1000)
        {
            var c2: Int = a * a + b * b;
            var c: Int = math.sqrt(c2).toInt;
            if (c * c == c2)
            {
                var p: Int = a + b + c;
                if (p < 1001)
                    t(p) = t(p) + 1;
            }
        }
    var j: Int = 0;
    for (k <- 1 to 1000)
        if (t(k) > t(j))
            j = k;
    printf("%d", j);
  }
  
}

