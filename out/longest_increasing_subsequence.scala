object longest_increasing_subsequence
{
  
  def dichofind(len : Int, tab : Array[Int], tofind : Int, a : Int, b : Int): Int = {
    if (a >= b - 1)
        return a;
    else
    {
        var c: Int = (a + b) / 2;
        if (tab(c) < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
  }
  
  def process(len : Int, tab : Array[Int]): Int = {
    var size :Array[Int] = new Array[Int](len);
    for (j <- 0 to len - 1)
        if (j == 0)
            size(j) = 0;
        else
            size(j) = len * 2;
    for (i <- 0 to len - 1)
    {
        var k: Int = dichofind(len, size, tab(i), 0, len - 1);
        if (size(k + 1) > tab(i))
            size(k + 1) = tab(i);
    }
    for (l <- 0 to len - 1)
        printf("%d ", size(l));
    for (m <- 0 to len - 1)
    {
        var k: Int = len - 1 - m;
        if (size(k) != len * 2)
            return k;
    }
    return 0;
  }
  
  def main(args : Array[String])
  {
    var n: Int = readInt().toInt;
    for (i <- 1 to n)
    {
        var len: Int = readInt().toInt;
        printf("%d\n", process(len, readLine().split(" ").map(_.toInt)));
    }
  }
  
}

