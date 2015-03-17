object aaa_06readcouple
{
  
  
  def main(args : Array[String])
  {
    for (i <- 1 to 3)
    {
      var (a, b) = readf2("{0,number} {1,number}").asInstanceOf[(Long, Long)] match { case x => (x._1.toInt, x._2.toInt) }
      printf("a = %d b = %d\n", a, b);
    }
    var l: Array[Int] = readLine().split(" ").map(_.toInt);
    for (j <- 0 to 9)
    {
      printf("%d\n", l(j));
    }
  }
  
}

