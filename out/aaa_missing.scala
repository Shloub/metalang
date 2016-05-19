object aaa_missing
{
  
  /*
  Ce test a été généré par Metalang.
*/
  def result(len : Int, tab : Array[Int]): Int = {
    var i2: Int=0;
    var i1: Int=0;
    var i: Int=0;
    var tab2 :Array[Boolean] = new Array[Boolean](len);
    for (i <- 0 to len - 1)
      tab2(i) = false;
    for (i1 <- 0 to len - 1)
    {
        printf("%d ", tab(i1));
        tab2(tab(i1)) = true;
    }
    printf("\n");
    for (i2 <- 0 to len - 1)
      if (!tab2(i2))
      return i2;
    return -1;
  }
  
  
  def main(args : Array[String])
  {
    var len: Int = readInt().toInt;
    printf("%d\n", len);
    var tab: Array[Int] = readLine().split(" ").map(_.toInt);
    printf("%d\n", result(len, tab));
  }
  
}

