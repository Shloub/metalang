object euler06
{
  
  
  def main(args : Array[String])
  {
    var lim: Int = 100;
    var sum: Int = lim * (lim + 1) / 2;
    var carressum: Int = sum * sum;
    var sumcarres: Int = lim * (lim + 1) * (2 * lim + 1) / 6;
    printf("%d", carressum - sumcarres);
  }
  
}

