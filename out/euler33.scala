object euler33
{
  
  def max2_0(a : Int, b : Int): Int = {
    if (a > b)
      return a;
    else
      return b;
  }
  
  def min2_0(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  def pgcd(a : Int, b : Int): Int = {
    var c: Int = min2_0(a, b);
    var d: Int = max2_0(a, b);
    var reste: Int = d % c;
    if (reste == 0)
      return c;
    else
      return pgcd(c, reste);
  }
  
  
  def main(args : Array[String])
  {
    var top: Int = 1;
    var bottom: Int = 1;
    for (i <- 1 to 9)
      for (j <- 1 to 9)
        for (k <- 1 to 9)
          if (i != j && j != k)
        {
          var a: Int = i * 10 + j;
          var b: Int = j * 10 + k;
          if (a * k == i * b)
          {
            printf("%d/%d\n", a, b);
            top = top * a;
            bottom = bottom * b;
          }
        }
    printf("%d/%d\n", top, bottom);
    var p: Int = pgcd(top, bottom);
    printf("pgcd=%d\n%d\n", p, bottom / p);
  }
  
}

