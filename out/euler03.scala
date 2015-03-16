object euler03
{
  
  
  def main(args : Array[String])
  {
    var maximum: Int = 1;
    var b0: Int = 2;
    var a: Int = 408464633;
    var sqrtia: Int = math.sqrt(a).toInt;
    while (a != 1)
    {
      var b: Int = b0;
      var found: Boolean = false;
      while (b <= sqrtia)
      {
        if ((a % b) == 0)
        {
          a = a / b;
          b0 = b;
          b = a;
          sqrtia = math.sqrt(a).toInt;
          found = true;
        }
        b = b + 1;
      }
      if (!found)
      {
        printf("%d\n", a);
        a = 1;
      }
    }
  }
  
}

