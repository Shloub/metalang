object euler31
{
  
  def result(sum : Int, t : Array[Int], maxIndex : Int, cache : Array[Array[Int]]): Int = {
    if (cache(sum)(maxIndex) != 0)
        return cache(sum)(maxIndex);
    else
        if (sum == 0 || maxIndex == 0)
            return 1;
        else
        {
            var out0: Int = 0;
            var div: Int = sum / t(maxIndex);
            for (i <- 0 to div)
                out0 = out0 + result(sum - i * t(maxIndex), t, maxIndex - 1, cache);
            cache(sum)(maxIndex) = out0;
            return out0;
        }
  }
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](8);
    for (i <- 0 to 7)
        t(i) = 0;
    t(0) = 1;
    t(1) = 2;
    t(2) = 5;
    t(3) = 10;
    t(4) = 20;
    t(5) = 50;
    t(6) = 100;
    t(7) = 200;
    var cache :Array[Array[Int]] = new Array[Array[Int]](201);
    for (j <- 0 to 200)
    {
        var o :Array[Int] = new Array[Int](8);
        for (k <- 0 to 7)
            o(k) = 0;
        cache(j) = o;
    }
    printf("%d", result(200, t, 7, cache));
  }
  
}

