object aaa_readints
{
  
  
  def main(args : Array[String])
  {
    var len: Int = readInt().toInt;
    printf("%d=len\n", len);
    var tab1: Array[Int] = readLine().split(" ").map(_.toInt);
    for (i <- 0 to len - 1)
        printf("%d=>%d\n", i, tab1(i));
    len = readInt().toInt;
    var tab2 :Array[Array[Int]] = new Array[Array[Int]](len - 1);
    for (a <- 0 to len - 2)
        tab2(a) = readLine().split(" ").map(_.toInt);
    for (i <- 0 to len - 2)
    {
        for (j <- 0 to len - 1)
            printf("%d ", tab2(i)(j));
        printf("\n");
    }
  }
  
}

