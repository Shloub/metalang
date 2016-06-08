object aaa_07triplet
{
  
  
  def main(args : Array[String])
  {
    for (i <- 1 to 3)
    
    {
        var (a, b, c) = readf3("{0,number} {1,number} {2,number}").asInstanceOf[(Long, Long, Long)] match { case x => (x._1.toInt, x._2.toInt, x._3.toInt) };
        printf("a = %d b = %dc =%d\n", a, b, c);
    }
    var l: Array[Int] = readLine().split(" ").map(_.toInt);
    for (j <- 0 to 9)
    
        printf("%d\n", l(j));
  }
  
}

