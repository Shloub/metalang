object euler09
{
  
  
  def main(args : Array[String])
  {
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (a <- 1 to 1000)
      for (b <- a + 1 to 1000)
      {
        var c: Int = 1000 - a - b;
        var a2b2: Int = a * a + b * b;
        var cc: Int = c * c;
        if (cc == a2b2 && c > a)
        {
          printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c);
        }
      }
  }
  
}

