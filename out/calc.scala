object calc
{
  
  /*
La suite de fibonaci
*/
  def fibo(a : Int, b : Int, i : Int): Int = {
    var j: Int=0;
    var out_U: Int = 0;
    var a2: Int = a;
    var b2: Int = b;
    for (j <- 0 to i + 1)
    {
      printf("%d", j);
      out_U = out_U + a2;
      var tmp: Int = b2;
      b2 = b2 + a2;
      a2 = tmp;
    }
    return out_U;
  }
  
  
  def main(args : Array[String])
  {
    printf("%d", fibo(1, 2, 4));
  }
  
}

