object euler52
{
  
  def chiffre_sort(a : Int): Int = {
    if (a < 10)
        return a;
    else
    {
        var b: Int = chiffre_sort(a / 10);
        var c: Int = a % 10;
        var d: Int = b % 10;
        var e: Int = b / 10;
        if (c < d)
            return c + b * 10;
        else
            return d + chiffre_sort(c + e * 10) * 10;
    }
  }
  
  def same_numbers(a : Int, b : Int, c : Int, d : Int, e : Int, f : Int): Boolean = {
    var ca: Int = chiffre_sort(a);
    return ca == chiffre_sort(b) && ca == chiffre_sort(c) && ca == chiffre_sort(d) && ca == chiffre_sort(e) && ca == chiffre_sort(f);
  }
  
  def main(args : Array[String])
  {
    var num: Int = 142857;
    if (same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5))
        printf("%d %d %d %d %d %d\n", num, num * 2, num * 3, num * 4, num * 5, num * 6);
  }
  
}

