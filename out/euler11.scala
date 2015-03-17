object euler11
{
  
  def max2_(a : Int, b : Int): Int = {
    if (a > b)
      return a;
    else
      return b;
  }
  
  def find(n : Int, m : Array[Array[Int]], x : Int, y : Int, dx : Int, dy : Int): Int = {
    if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1;
    else if (n == 0)
      return 1;
    else
      return m(y)(x) * find(n - 1, m, x + dx, y + dy, dx, dy);
  }
  
  
  def main(args : Array[String])
  {
    var directions :Array[(Int, Int)] = new Array[(Int, Int)](8);
    for (i <- 0 to 8 - 1)
      if (i == 0)
      directions(i) = (0, 1);
    else if (i == 1)
      directions(i) = (1, 0);
    else if (i == 2)
      directions(i) = (0, -1);
    else if (i == 3)
      directions(i) = (-1, 0);
    else if (i == 4)
      directions(i) = (1, 1);
    else if (i == 5)
      directions(i) = (1, -1);
    else if (i == 6)
      directions(i) = (-1, 1);
    else
      directions(i) = (-1, -1);
    var max0: Int = 0;
    var m :Array[Array[Int]] = new Array[Array[Int]](20);
    for (c <- 0 to 20 - 1)
      m(c) = readLine().split(" ").map(_.toInt);
    for (j <- 0 to 7)
    {
      var (dx, dy) = directions(j)
      for (x <- 0 to 19)
        for (y <- 0 to 19)
          max0 = max2_(max0, find(4, m, x, y, dx, dy));
    }
    printf("%d\n", max0);
  }
  
}

