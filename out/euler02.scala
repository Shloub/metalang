object euler02
{
  
  
  def main(args : Array[String])
  {
    var a: Int = 1;
    var b: Int = 2;
    var sum: Int = 0;
    while (a < 4000000)
    {
        if (a % 2 == 0)
            sum = sum + a;
        var c: Int = a;
        a = b;
        b = b + c;
    }
    printf("%d\n", sum);
  }
  
}

