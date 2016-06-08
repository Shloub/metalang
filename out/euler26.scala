object euler26
{
  
  def periode(restes : Array[Int], _len : Int, _a : Int, b : Int): Int = {
    var len = _len;
    var a = _a;
    while (a != 0)
    {
        var chiffre: Int = a / b;
        var reste: Int = a % b;
        for (i <- 0 to len - 1)
        
            if (restes(i) == reste)
                return len - i;
        restes(len) = reste;
        len = len + 1;
        a = reste * 10;
    }
    return 0;
  }
  
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](1000);
    for (j <- 0 to 1000 - 1)
    
        t(j) = 0;
    var m: Int = 0;
    var mi: Int = 0;
    for (i <- 1 to 1000)
    
    {
        var p: Int = periode(t, 0, 1, i);
        if (p > m)
        {
            mi = i;
            m = p;
        }
    }
    printf("%d\n%d\n", mi, m);
  }
  
}

