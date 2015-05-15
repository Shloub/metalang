object euler36
{
  
  def palindrome2(pow2 : Array[Int], n : Int): Boolean = {
    var k: Int=0;
    var j: Int=0;
    var i: Int=0;
    var t :Array[Boolean] = new Array[Boolean](20);
    for (i <- 0 to 20 - 1)
      t(i) = n / pow2(i) % 2 == 1;
    var nnum: Int = 0;
    for (j <- 1 to 19)
      if (t(j))
      nnum = j;
    for (k <- 0 to nnum / 2)
      if (t(k) != t(nnum - k))
      return false;
    return true;
  }
  
  
  def main(args : Array[String])
  {
    var p: Int = 1;
    var pow2 :Array[Int] = new Array[Int](20);
    for (i <- 0 to 20 - 1)
    {
      p = p * 2;
      pow2(i) = p / 2;
    }
    var sum: Int = 0;
    for (d <- 1 to 9)
    {
      if (palindrome2(pow2, d))
      {
        printf("%d\n", d);
        sum = sum + d;
      }
      if (palindrome2(pow2, d * 10 + d))
      {
        printf("%d\n", d * 10 + d);
        sum = sum + d * 10 + d;
      }
    }
    for (a0 <- 0 to 4)
    {
      var a: Int = a0 * 2 + 1;
      for (b <- 0 to 9)
      {
        for (c <- 0 to 9)
        {
          var num0: Int = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a;
          if (palindrome2(pow2, num0))
          {
            printf("%d\n", num0);
            sum = sum + num0;
          }
          var num1: Int = a * 10000 + b * 1000 + c * 100 + b * 10 + a;
          if (palindrome2(pow2, num1))
          {
            printf("%d\n", num1);
            sum = sum + num1;
          }
        }
        var num2: Int = a * 100 + b * 10 + a;
        if (palindrome2(pow2, num2))
        {
          printf("%d\n", num2);
          sum = sum + num2;
        }
        var num3: Int = a * 1000 + b * 100 + b * 10 + a;
        if (palindrome2(pow2, num3))
        {
          printf("%d\n", num3);
          sum = sum + num3;
        }
      }
    }
    printf("sum=%d\n", sum);
  }
  
}

