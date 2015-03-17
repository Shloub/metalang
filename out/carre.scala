object carre
{
  
  def min2_(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  
  def main(args : Array[String])
  {
    var x: Int = readInt().toInt;
    var y: Int = readInt().toInt;
    var tab :Array[Array[Int]] = new Array[Array[Int]](y);
    for (d <- 0 to y - 1)
      tab(d) = readLine().split(" ").map(_.toInt);
    for (ix <- 1 to x - 1)
      for (iy <- 1 to y - 1)
        if (tab(iy)(ix) == 1)
        tab(iy)(ix) = min2_(min2_(tab(iy)(ix - 1), tab(iy - 1)(ix)), tab(iy - 1)(ix - 1)) + 1;
    for (jy <- 0 to y - 1)
    {
      for (jx <- 0 to x - 1)
      {
        printf("%d ", tab(jy)(jx));
      }
      printf("\n");
    }
  }
  
}

